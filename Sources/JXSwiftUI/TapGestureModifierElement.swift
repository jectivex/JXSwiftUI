import JXBridge
import JXKit
import SwiftUI

/// Adds a tap gesture to its target view.
struct TapGestureModifierElement: Element {
    private let target: Content
    private let onTapFunction: JXValue

    init(jxValue: JXValue) throws {
        self.target = try Content(jxValue: jxValue["target"])
        self.onTapFunction = try jxValue["action"]
        guard onTapFunction.isFunction else {
            throw JXError(message: "Expected a tap function. Received '\(onTapFunction.description)'")
        }
    }

    var elementType: ElementType {
        return .tapGestureModifier
    }

    func view(errorHandler: ErrorHandler?) -> any View {
        return target.element(errorHandler: errorHandler)
            .view(errorHandler: errorHandler)
            .onTapGesture {
                onTapGesture(errorHandler: errorHandler)
            }
    }
    
    static func js(namespace: JXNamespace) -> String? {
        """
function(target, action) {
    const e = new \(namespace.value).JXElement('\(ElementType.tapGestureModifier.rawValue)');
    e.target = target;
    e.action = action;
    return e;
}
"""
    }
    
    static func modifierJS(for modifier: String, namespace: JXNamespace) -> String? {
        guard modifier == "onTapGesture" else {
            return nil
        }
        return """
function(action) {
    return \(namespace.value).\(ElementType.tapGestureModifier.rawValue)(this, action);
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
