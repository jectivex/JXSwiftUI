import Combine
import JXBridge
import JXKit
import SwiftUI

/// A SwiftUI view that displays content defined in JavaScript.
public struct JXView: View {
    @Environment(\.jx) private var inheritedJXEnvironment: JXEnvironment?
    @StateObject private var effectiveJXEnvironment = EffectiveJXEnvironment()
    @StateObject private var scriptsObservable = ViewScriptsObservable()
    private let context: JXContext?
    private let errorHandler: ((Error) -> Void)?
    private let content: (JXContext) throws -> JXValue
    
    /// Construct a view whose content is defined in JavaScript.
    ///
    /// - Parameters:
    ///   - context: An existing context. If not supplied, we use the ``JXEnvironment`` value, which defaults to a new context.
    ///   - errorHandler: An optional handler for JavaScript errors. If not supplied, we use the ``JXEnvironment`` value, which defaults to logging errors via `JXContext.configuration.log`.
    ///   - content: A closure returning a `JXValue` reprenting the content view. Typically you will use the supplied context to `eval` JavaScript that returns a `JXSwiftUI` view.
    public init(context: JXContext? = nil, errorHandler: ((Error) -> Void)? = nil, content: @escaping (JXContext) throws -> JXValue) {
        self.context = context
        self.errorHandler = errorHandler
        self.content = content
    }
    
    public var body: some View {
        effectiveJXEnvironment.initialize(context: context, errorHandler: errorHandler, environment: inheritedJXEnvironment)
        let jxErrorHandler = ErrorHandler(handler: effectiveJXEnvironment.environment.errorHandler, elementPath: [])
        return contentElement(errorHandler: jxErrorHandler)
            .view(errorHandler: jxErrorHandler)
            .eraseToAnyView()
            .jxEnvironment(effectiveJXEnvironment.environment)
    }
    
    private func contentElement(errorHandler: ErrorHandler) -> Element {
        let context = effectiveJXEnvironment.environment.context
        do {
            if context.registry.module(for: .jxswiftui) == nil {
                try context.registry.register(JXSwiftUI())
            }
            let jxValue: JXValue
            if context.configuration.isDynamicReloadEnabled {
                // When dynamic reloading is enabled, track which script resources this view uses and re-run our body when they change
                scriptsObservable.initialize(context: context)
                let result = try context.trackingScriptsAccess {
                    return try content(context)
                }
                scriptsObservable.accessedScripts = result.accessed
                jxValue = result.value
            } else {
                jxValue = try content(context)
            }
            return try Content(jxValue: jxValue).element(errorHandler: errorHandler)
        } catch {
            errorHandler.handle(error)
            return EmptyElement()
        }
    }
}

/// Used to hold the context and error handler in effect.
private class EffectiveJXEnvironment: ObservableObject {
    func initialize(context: JXContext?, errorHandler: ((Error) -> Void)?, environment: JXEnvironment?) {
        guard _environment == nil else {
            return
        }
        _environment = JXEnvironment(context: context ?? environment?.context, errorHandler: errorHandler ?? environment?.errorHandler)
    }

    var environment: JXEnvironment {
        if let environment = _environment {
            return environment
        }
        let environment = JXEnvironment()
        _environment = environment
        return environment
    }
    var _environment: JXEnvironment?
}


/// Used to update each view if any accessed scripts change.
private class ViewScriptsObservable: ObservableObject {
    private var context: JXContext?
    private var scriptsSubscription: JXCancellable?
    
    func initialize(context: JXContext) {
        guard context !== self.context else {
            return
        }
        self.context = context
        self.scriptsSubscription = context.onScriptsDidChange { [weak self] in
            self?.onScriptsDidChange($0)
        }
    }
    
    var accessedScripts: Set<String> = []
    
    private func onScriptsDidChange(_ scripts: Set<String>) {
        if !scripts.isDisjoint(with: accessedScripts) {
            objectWillChange.send()
        }
    }
}
