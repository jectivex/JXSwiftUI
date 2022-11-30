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
}

private class JSState: ObservableObject {
    let observer = WillChangeObserver()
    var observerSubscription: AnyCancellable?
    
    var state: JXValue?
    var stateOwnerClassName: String?
    
    init() {
        observerSubscription = observer.objectWillChange.sink { [weak self] _ in self?.objectWillChange.send() }
    }
}
