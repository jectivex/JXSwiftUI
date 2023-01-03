import JXBridge
import JXKit
import SwiftUI

extension JXSwiftUISupport {
    /// Prevents submission of the target view from triggering `onSubmit` actions higher up the view hierarchy.
    ///
    /// Supported calls:
    ///
    ///     - .submitScope()
    ///     - .submitScope(bool)
    public enum submitScope {}
}

struct SubmitScopeModifier: Element {
    private let target: Content
    private let blocking: Bool

    init(jxValue: JXValue) throws {
        self.target = try Content(jxValue: jxValue["target"])
        self.blocking = try jxValue["blocking"].bool
    }

    func view(errorHandler: ErrorHandler) -> any View {
        return target.element(errorHandler: errorHandler)
            .view(errorHandler: errorHandler)
            .submitScope(blocking)
    }

    static func modifierJS(namespace: JXNamespace) -> String? {
        return """
function(blocking) {
    const e = new \(JSCodeGenerator.elementClass)('\(ElementType.submitScopeModifier.rawValue)');
    e.target = this;
    e.blocking = blocking === undefined || blocking;
    return e;
}
"""
    }
}
