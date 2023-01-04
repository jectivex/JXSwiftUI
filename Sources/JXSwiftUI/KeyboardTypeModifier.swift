#if !os(macOS)
import JXKit
import SwiftUI

extension JXSwiftUISupport {
    /// Sets the keyboard type on a target view.
    ///
    /// Supported calls:
    ///
    ///     - .keyboardType(UIKeyboardType)
    public enum keyboardType {}

    /// Use a JavaScript string to name any standard `UIKit.UIKeyboardType` value, e.g. `'emailAddress'`.
    public enum UIKeyboardType {}
}

struct KeyboardTypeModifier: SingleValueModifier {
    static let type = ElementType.keyboardTypeModifier
    let target: Content
    let value: UIKeyboardType

    static func convert(_ value: JXValue) throws -> UIKeyboardType {
        return try value.convey()
    }

    func apply(to view: any View, errorHandler: ErrorHandler) -> any View {
        return view.keyboardType(value)
    }
}

/// - Note: `UIKeyboardType` already conforms to `RawRepresentable` as a number, so use `JXConvertible` for readable string values.
extension UIKeyboardType: JXConvertible {
    public static func fromJX(_ value: JXValue) throws -> UIKeyboardType {
        switch try value.string {
        case "default":
            return .default
        case "asciiCapable":
            return .asciiCapable
        case "numbersAndPunctuation":
            return .numbersAndPunctuation
        case "URL":
            return .URL
        case "numberPad":
            return .numberPad
        case "phonePad":
            return .phonePad
        case "namePhonePad":
            return .namePhonePad
        case "emailAddress":
            return .emailAddress
        case "decimalPad":
            return .decimalPad
        case "twitter":
            return .twitter
        case "asciiCapableNumberPad":
            return .asciiCapableNumberPad
        case "webSearch":
            return .webSearch
        default:
            throw JXError.invalid(value: try value.string, for: UIKeyboardType.self)
        }
    }

    public func toJX(in context: JXContext) throws -> JXValue {
        switch self {
        case .default:
            return context.string("default")
        case .asciiCapable:
            return context.string("asciiCapable")
        case .numbersAndPunctuation:
            return context.string("numbersAndPunctuation")
        case .URL:
            return context.string("URL")
        case .numberPad:
            return context.string("numberPad")
        case .phonePad:
            return context.string("phonePad")
        case .namePhonePad:
            return context.string("namePhonePad")
        case .emailAddress:
            return context.string("emailAddress")
        case .decimalPad:
            return context.string("decimalPad")
        case .twitter:
            return context.string("twitter")
        case .webSearch:
            return context.string("webSearch")
        case .asciiCapableNumberPad:
            return context.string("asciiCapableNumberPad")
        @unknown default:
            return context.string("unknown")
        }
    }
}
#endif
