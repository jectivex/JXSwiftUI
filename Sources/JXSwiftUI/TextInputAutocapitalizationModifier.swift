#if !os(macOS)
import JXBridge
import JXKit
import SwiftUI

extension JXSwiftUISupport {
    /// Sets the autocapitalization behavior on a target view.
    ///
    /// Supported calls:
    ///
    ///     - .textInputAutocapitalization(TextInputAutocapitalization)
    public enum textInputAutocapitalization {}

    /// Use a JavaScript string to name any standard `SwiftUI.TextInputAutocapitalization` value, e.g. `'words'`.
    public enum TextInputAutocapitalization {}
}

struct TextInputAutocapitalizationModifier: SingleValueModifier {
    static let type = ElementType.textInputAutocapitalizationModifier
    let target: Content
    let value: TextInputAutocapitalization

    static func convert(_ value: JXValue) throws -> TextInputAutocapitalization {
        let uitype = try value.convey(to: UITextAutocapitalizationType.self)
        guard let type = TextInputAutocapitalization(uitype) else {
            throw JXError.internalError("TextInputAutocapitalization")
        }
        return type
    }

    func apply(to view: any View, errorHandler: ErrorHandler) -> any View {
        return view.textInputAutocapitalization(value)
    }
}

/// - Note: `UIKeyboardType` already conforms to `RawRepresentable` as a number, so use `JXConvertible` for readable string values.
/// - Note: We use TextInputAutocapitalization values to match the SwiftUI API.
extension UITextAutocapitalizationType: JXConvertible {
    public static func fromJX(_ value: JXValue) throws -> UITextAutocapitalizationType {
        switch try value.string {
        case "characters":
            return .allCharacters
        case "never":
            return .none
        case "sentences":
            return .sentences
        case "words":
            return .words
        default:
            throw JXError.invalid(value: try value.string, for: UITextAutocapitalizationType.self)
        }
    }

    public func toJX(in context: JXContext) throws -> JXValue {
        switch self {
        case .allCharacters:
            return context.string("characters")
        case .none:
            return context.string("never")
        case .sentences:
            return context.string("sentences")
        case .words:
            return context.string("words")
        default:
            return context.string("unknown")
        }
    }
}
#endif
