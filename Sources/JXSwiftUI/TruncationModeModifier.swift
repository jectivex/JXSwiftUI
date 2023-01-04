import JXKit
import SwiftUI

extension JXSwiftUISupport {
    /// Sets the text truncation mode on a target view.
    ///
    /// Supported calls:
    ///
    ///     - .truncationMode(TruncationMode)
    public enum truncationMode {}

    /// Use a JavaScript string to name any standard `SwiftUI.Text.TruncationMode` value, e.g. `'tail'`.
    public enum TruncationMode {}
}

struct TruncationModeModifier: SingleValueModifier {
    static let type = ElementType.truncationModeModifier
    let target: Content
    let value: Text.TruncationMode

    static func convert(_ value: JXValue) throws -> Text.TruncationMode {
        return try value.convey()
    }

    func apply(to view: any View, errorHandler: ErrorHandler) -> any View {
        return view.truncationMode(value)
    }
}

extension Text.TruncationMode: RawRepresentable {
    public init?(rawValue: String) {
        switch rawValue {
        case "head":
            self = .head
        case "tail":
            self = .tail
        case "middle":
            self = .middle
        default:
            return nil
        }
    }

    public var rawValue: String {
        switch self {
        case .head:
            return "head"
        case .tail:
            return "tail"
        case .middle:
            return "middle"
        @unknown default:
            return "unknown"
        }
    }
}
