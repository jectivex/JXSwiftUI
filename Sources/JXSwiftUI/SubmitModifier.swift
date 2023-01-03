import JXBridge
import JXKit
import SwiftUI

extension JXSwiftUISupport {
    /// Sets a submit action on a target view.
    ///
    /// Supported calls:
    ///
    ///     - .onSubmit(() => { action })
    ///     - .onSubmit('trigger', () => { action })
    ///     - .onSubmit(['trigger', 'trigger'], () => { action })
    ///
    /// Supported triggers are 'text' and 'search'.
    public enum onSubmit {}
}

struct SubmitModifier: Element {
    private let target: Content
    private let triggers: SubmitTriggers
    private let actionFunction: JXValue

    init(jxValue: JXValue) throws {
        self.target = try Content(jxValue: jxValue["target"])
        let triggersValue = try jxValue["triggers"]
        if triggersValue.isArray {
            let strings = try triggersValue.array.map { try $0.string }
            self.triggers = try strings.reduce(into: SubmitTriggers()) { result, string in
                let triggers = try Self.triggers(for: string)
                result.insert(triggers)
            }
        } else {
            self.triggers = try Self.triggers(for: triggersValue.string)
        }
        self.actionFunction = try jxValue["action"]
    }

    func view(errorHandler: ErrorHandler) -> any View {
        return target.element(errorHandler: errorHandler)
            .view(errorHandler: errorHandler)
            .onSubmit(of: triggers) {
                onAction(errorHandler: errorHandler)
            }
    }

    static func modifierJS(namespace: JXNamespace) -> String? {
        return """
function(triggersOrAction, action) {
    const e = new \(JSCodeGenerator.elementClass)('\(ElementType.submitModifier.rawValue)');
    e.target = this;
    if (typeof(triggersOrAction) === 'function') {
        e.triggers = 'text';
        e.action = triggersOrAction;
    } else {
        e.triggers = triggersOrAction;
        e.action = action;
    }
    return e;
}
"""
    }

    private static func triggers(for string: String) throws -> SubmitTriggers {
        switch string {
        case "text":
            return .text
        case "search":
            return .search
        default:
            throw JXError.invalid(value: string, for: SubmitTriggers.self)
        }
    }

    private func onAction(errorHandler: ErrorHandler) {
        do {
            try actionFunction.call()
        } catch {
            errorHandler.attr("action").handle(error)
        }
    }
}
