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

struct TextInputAutocapitalizationModifier: Element {
    private let target: Content
    private let type: TextInputAutocapitalization

    init(jxValue: JXValue) throws {
        self.target = try Content(jxValue: jxValue["target"])
        let uitype = try jxValue["type"].convey(to: UITextAutocapitalizationType.self)
        guard let type = TextInputAutocapitalization(uitype) else {
            throw JXError.internalError("TextInputAutocapitalization")
        }
        self.type = type
    }

    func view(errorHandler: ErrorHandler) -> any View {
        return target.element(errorHandler: errorHandler)
            .view(errorHandler: errorHandler)
            .textInputAutocapitalization(type)
    }

    static func modifierJS(namespace: JXNamespace) -> String? {
        return """
function(type) {
    const e = new \(JSCodeGenerator.elementClass)('\(ElementType.textInputAutocapitalizationModifier.rawValue)');
    e.target = this;
    e.type = type;
    return e;
}
"""
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
