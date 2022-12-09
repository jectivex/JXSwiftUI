import JXBridge
import JXKit
import SwiftUI

/// Adds a tap gesture to its target view.
struct TapGestureModifier: Element {
    private let target: Content
    private let onTapFunction: JXValue

    init(jxValue: JXValue) throws {
        self.target = try Content(jxValue: jxValue["target"])
        self.onTapFunction = try jxValue["action"]
        guard onTapFunction.isFunction else {
            throw JXError(message: "Expected a tap function. Received '\(onTapFunction)'")
        }
    }

    func view(errorHandler: ErrorHandler?) -> any View {
        return target.element(errorHandler: errorHandler)
            .view(errorHandler: errorHandler)
            .onTapGesture {
                onTapGesture(errorHandler: errorHandler)
            }
    }
    
    static func modifierJS(namespace: JXNamespace) -> String? {
        return """
function(action) {
    const e = new \(JXNamespace.default).\(JSCodeGenerator.elementClass)('\(ElementType.tapGestureModifier.rawValue)');
    e.target = this;
    e.action = action;
    return e;
}
"""
    }

    private func onTapGesture(errorHandler: ErrorHandler?) {
        do {
            try onTapFunction.call()
        } catch {
            errorHandler?.in(.tapGestureModifier).handle(error)
        }
    }
}
