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

struct TextFieldStyleModifier: SingleValueModifier {
    static let type = ElementType.textFieldStyleModifier
    let target: Content
    let value: any TextFieldStyle

    static func convert(_ value: JXValue) throws -> any TextFieldStyle {
        let styleString = try value.string
        switch styleString {
        case "automatic":
            return .automatic
        case "plain":
            return .plain
        case "roundedBorder":
            return .roundedBorder
#if os(macOS)
        case "squareBorder":
            return .squareBorder
#endif
        default:
            throw JXError.invalid(value: styleString, for: (any TextFieldStyle).self)
        }
    }

    func apply(to view: any View, errorHandler: ErrorHandler) -> any View {
        return view.textFieldStyle(value)
    }
}
