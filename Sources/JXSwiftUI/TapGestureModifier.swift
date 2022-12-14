import JXBridge
import JXKit
import SwiftUI

extension JXSwiftUISupport {
    /// Sets a tap gesture on a target view.
    ///
    /// Supported calls:
    ///
    ///     - .onTapGesture(() => { action })
    ///     - .onTapGesture(count, () => { action })
    public enum onTapGesture {}
}

struct TapGestureModifier: Element {
    private let target: Content
    private let count: Int
    private let onTapFunction: JXValue

    init(jxValue: JXValue) throws {
        self.target = try Content(jxValue: jxValue["target"])
        self.count = try jxValue["count"].int
        self.onTapFunction = try jxValue["action"]
        guard onTapFunction.isFunction else {
            throw JXError(message: "Expected a tap function. Received '\(onTapFunction)'")
        }
    }

    func view(errorHandler: ErrorHandler) -> any View {
        return target.element(errorHandler: errorHandler)
            .view(errorHandler: errorHandler)
            .onTapGesture(count: count) {
                onTapGesture(errorHandler: errorHandler)
            }
    }
    
    static func modifierJS(namespace: JXNamespace) -> String? {
        return """
function(countOrAction, action) {
    const e = new \(JSCodeGenerator.elementClass)('\(ElementType.tapGestureModifier.rawValue)');
    e.target = this;
    if (action === undefined) {
        e.count = 1;
        e.action = countOrAction;
    } else {
        e.count = countOrAction;
        e.action = action;
    }
    return e;
}
"""
    }

    private func onTapGesture(errorHandler: ErrorHandler) {
        do {
            try onTapFunction.call()
        } catch {
            errorHandler.in(.tapGestureModifier).handle(error)
        }
    }
}
