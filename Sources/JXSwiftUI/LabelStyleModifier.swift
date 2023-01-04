import JXBridge
import JXKit
import SwiftUI

extension JXSwiftUISupport {
    /// Sets the label style on a target view.
    ///
    /// Supported calls:
    ///
    ///     - .labelStyle(LabelStyle)
    public enum labelStyle {}

    /// Use a JavaScript string to name any standard `SwiftUI.LabelStyle` value, e.g. `'iconOnly'`.
    public enum LabelStyle {}
}

struct LabelStyleModifier: SingleValueModifier {
    static let type = ElementType.labelStyleModifier
    let target: Content
    let value: any LabelStyle

    static func convert(_ value: JXValue) throws -> any LabelStyle {
        let styleString = try value.string
        switch styleString {
        case "automatic":
            return .automatic
        case "iconOnly":
            return .iconOnly
        case "titleAndIcon":
            return .titleAndIcon
        case "titleOnly":
            return .titleOnly
        default:
            throw JXError.invalid(value: styleString, for: (any LabelStyle).self)
        }
    }

    func apply(to view: any View, errorHandler: ErrorHandler) -> any View {
        return view.labelStyle(value)
    }
}
