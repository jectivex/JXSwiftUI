import Combine
import JXBridge
import JXKit
import SwiftUI

/// Vends a custom view defined in JS.
struct CustomInfo: ElementInfo {
    let jxValue: JXValue
    let jsClassName: String

    init(jxValue: JXValue) throws {
        self.jxValue = jxValue
        self.jsClassName = try jxValue["constructor"]["name"].string
    }

    var elementType: ElementType {
        return .custom
    }
    
    @ViewBuilder
    func view(errorHandler: ErrorHandler?) -> any View {
        CustomView(info: self, errorHandler: errorHandler)
    }
    
    static func js(namespace: JXNamespace) -> String? {
        return nil
    }
}

private struct CustomView: View {
    let info: CustomInfo
    let errorHandler: ErrorHandler?

    @StateObject private var jsState = JSState()
    
    var body: some View {
        AnyView(evaluateJSBody().view(errorHandler: errorHandler))
    }

    private func evaluateJSBody() -> ElementInfo {
        do {
            try manageJSState()
            try updateJSObservers()
            let bodyValue = try info.jxValue.invokeMethod(JSCodeGenerator.bodyFunction, withArguments: [])
            return try CustomInfo.info(for: bodyValue, in: info.jsClassName)
        } catch {
            errorHandler?(error)
            return EmptyInfo()
        }
    }
    
    private func manageJSState() throws {
        if let state = jsState.state, let stateOwnerClassName = jsState.stateOwnerClassName, stateOwnerClassName == info.jsClassName {
            // If we have previous state from the same JS view class, transfer it to the JS view.
            // This preserves state when the parent view's body() is re-evaluated and a new JS
            // view is constructed, but is being backed by the same SwiftUI view. In cases where
            // it's the same JS view instance, it has no real effect
            try info.jxValue.setProperty(JSCodeGenerator.stateProperty, state)
        } else {
            // If we don't have previous JS state, cache the JS view's state for injection next time.
            // Assign an observer so that any state change triggers an update on our state object,
            // causing this view to re-evaluate its body. JS views can use the initState() function
            // to initialize expensive state only when it won't get overwritten
            try info.jxValue[JSCodeGenerator.initStateFunction].call()
            let state = try info.jxValue[JSCodeGenerator.stateProperty]
            let observerValue = info.jxValue.context.object(peer: jsState.observer)
            try state.setProperty(JSCodeGenerator.observerProperty, observerValue)
            jsState.state = state
            jsState.stateOwnerClassName = info.jsClassName
        }
    }
    
    private func updateJSObservers() throws {
        // Gather all observables from the JS view and its state object
        var observables: [ObjectIdentifier: any ObservableObject] = [:]
        try addObservables(in: info.jxValue[JSCodeGenerator.observedProperty], to: &observables)
        try addObservables(in: info.jxValue[JSCodeGenerator.stateProperty][JSCodeGenerator.observedProperty], to: &observables)
        
        // Unsubscribe observables we're no longer observing
        for entry in jsState.observed {
            if !observables.keys.contains(entry.key) {
                jsState.observed[entry.key] = nil
            }
        }
        // Subscribe to new observables so that a change will fire jsState.objectWillChange()
        for entry in observables {
            if !jsState.observed.keys.contains(entry.key) {
                if let publisher = (entry.value.objectWillChange as any Publisher) as? ObservableObjectPublisher {
                    jsState.observed[entry.key] = publisher.sink { [weak jsState] _ in
                        jsState?.objectWillChange.send()
                    }
                }
            }
        }
    }
    
    private func addObservables(in jsArray: JXValue, to dict: inout [ObjectIdentifier: any ObservableObject]) throws {
        for entry in try jsArray.dictionary {
            do {
                let observable = try entry.value.convey(to: (any ObservableObject).self)
                dict[ObjectIdentifier(observable)] = observable
            } catch JXErrors.cannotConvey {
                throw JXSwiftUIErrors.valueNotObservable(info.jsClassName, entry.key)
            }
        }
    }
}

private class JSState: ObservableObject {
    let observer = WillChangeObserver()
    var observerSubscription: AnyCancellable?
    var observed: [ObjectIdentifier: AnyCancellable] = [:]
    
    var state: JXValue?
    var stateOwnerClassName: String?
    
    init() {
        observerSubscription = observer.objectWillChange.sink { [weak self] _ in self?.objectWillChange.send() }
    }
}
