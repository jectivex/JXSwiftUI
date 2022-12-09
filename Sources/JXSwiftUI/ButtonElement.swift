import JXBridge
import JXKit
import SwiftUI

/// Vends a `SwiftUI.Button`.
struct ButtonElement: Element {
    private let content: Content
    private let actionFunction: JXValue

    init(jxValue: JXValue) throws {
        self.content = try Content(jxValue: jxValue["content"])
        self.actionFunction = try jxValue["action"]
        guard actionFunction.isFunction else {
            throw JXError(message: "Expected an action function. Received '\(actionFunction)'")
        }
    }

    func view(errorHandler: ErrorHandler?) -> any View {
        let errorHandler = errorHandler?.in(.button)
        return Button(action: {
            onAction(errorHandler: errorHandler)
        }) {
            content.element(errorHandler: errorHandler)
                .view(errorHandler: errorHandler)
                .eraseToAnyView()
        }
    }
    
    static func js(namespace: JXNamespace) -> String? {
        // Button('label', () => { action }) or Button(() => { action }, <content>)
"""
function(actionOrLabel, actionOrContent) {
    const e = new \(JXNamespace.default).\(JSCodeGenerator.elementClass)('\(ElementType.button.rawValue)');
    if (typeof(actionOrLabel) === 'string') {
        e.action = actionOrContent;
        e.content = \(namespace).Text(actionOrLabel);
    } else {
        e.action = actionOrLabel;
        e.content = actionOrContent;
    }
    return e;
}
"""
    }
    
    private func onAction(errorHandler: ErrorHandler?) {
        do {
            try actionFunction.call()
        } catch {
            errorHandler?.attr("action").handle(error)
        }
    }
}
