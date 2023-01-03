#if !os(macOS)
import JXBridge
import JXKit
import SwiftUI

extension JXSwiftUISupport {
    /// Disables autocorrection on a target view.
    ///
    /// Supported calls:
    ///
    ///     - .autocorrectionDisabled()
    ///     - .autocorrectionDisabled(bool)
    public enum autocorrectionDisabled {}
}

struct AutocorrectionDisabledModifier: Element {
    private let target: Content
    private let disabled: Bool

    init(jxValue: JXValue) throws {
        self.target = try Content(jxValue: jxValue["target"])
        self.disabled = try jxValue["disabled"].bool
    }

    func view(errorHandler: ErrorHandler) -> any View {
        return target.element(errorHandler: errorHandler)
            .view(errorHandler: errorHandler)
            .autocorrectionDisabled(disabled)
    }

    static func modifierJS(namespace: JXNamespace) -> String? {
        return """
function(disabled) {
    const e = new \(JSCodeGenerator.elementClass)('\(ElementType.autocorrectionDisabledModifier.rawValue)');
    e.target = this;
    e.disabled = disabled === undefined || disabled;
    return e;
}
"""
    }
}
#endif
