import JXBridge
import JXKit
import SwiftUI

extension JXSwiftUISupport {
    /// Sets the text field style on a target view.
    ///
    /// Supported calls:
    ///
    ///     - .textFieldStyle(TextFieldStyle)
    public enum textFieldStyle {}

    /// Use a JavaScript string to name any standard `SwiftUI.TextFieldStyle` value, e.g. `'automatic'`.
    public enum TextFieldStyle {}
}

struct TextFieldStyleModifier: Element {
    private let target: Content
    private let style: any TextFieldStyle

    init(jxValue: JXValue) throws {
        self.target = try Content(jxValue: jxValue["target"])
        let styleString = try jxValue["style"].string
        switch styleString {
        case "automatic":
            self.style = .automatic
        case "plain":
            self.style = .plain
        case "roundedBorder":
            self.style = .roundedBorder
#if os(macOS)
        case "squareBorder":
            self.style = .squareBorder
#endif
        default:
            throw JXError.invalid(value: styleString, for: (any TextFieldStyle).self)
        }
    }

    func view(errorHandler: ErrorHandler) -> any View {
        return target.element(errorHandler: errorHandler)
            .view(errorHandler: errorHandler)
            .textFieldStyle(style)
    }

    static func modifierJS(namespace: JXNamespace) -> String? {
        return """
function(style) {
    const e = new \(JSCodeGenerator.elementClass)('\(ElementType.textFieldStyleModifier.rawValue)');
    e.target = this;
    e.style = style;
    return e;
}
"""
    }
}
