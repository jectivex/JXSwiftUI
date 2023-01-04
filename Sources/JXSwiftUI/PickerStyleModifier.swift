import JXBridge
import JXKit
import SwiftUI

extension JXSwiftUISupport {
    /// Sets the picker style on a target view.
    ///
    /// Supported calls:
    ///
    ///     - .pickerStyle(PickerStyle)
    public enum pickerStyle {}

    /// Use a JavaScript string to name any standard `SwiftUI.PickerStyle` value, e.g. `'automatic'`.
    public enum PickerStyle {}
}

struct PickerStyleModifier: SingleValueModifier {
    static let type = ElementType.pickerStyleModifier
    let target: Content
    let value: any PickerStyle

    static func convert(_ value: JXValue) throws -> any PickerStyle {
        let styleString = try value.string
        switch styleString {
        case "automatic":
            return .automatic
        case "inline":
            return .inline
        case "menu":
            return .menu
#if os(macOS)
        case "radioGroup":
            return .radioGroup
#endif
        case "segmented":
            return .segmented
#if !os(macOS)
        case "wheel":
            return .wheel
#endif
        default:
            throw JXError.invalid(value: styleString, for: (any PickerStyle).self)
        }
    }

    func apply(to view: any View, errorHandler: ErrorHandler) -> any View {
        return view.pickerStyle(value)
    }
}
