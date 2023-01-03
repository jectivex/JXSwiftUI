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

struct PickerStyleModifier: Element {
    private let target: Content
    private let style: any PickerStyle

    init(jxValue: JXValue) throws {
        self.target = try Content(jxValue: jxValue["target"])
        let styleString = try jxValue["style"].string
        switch styleString {
        case "automatic":
            self.style = .automatic
        case "inline":
            self.style = .inline
        case "menu":
            self.style = .menu
#if os(macOS)
        case "radioGroup":
            self.style = .radioGroup
#endif
        case "segmented":
            self.style = .segmented
#if !os(macOS)
        case "wheel":
            self.style = .wheel
#endif
        default:
            throw JXError.invalid(value: styleString, for: (any PickerStyle).self)
        }
    }

    func view(errorHandler: ErrorHandler) -> any View {
        return target.element(errorHandler: errorHandler)
            .view(errorHandler: errorHandler)
            .pickerStyle(style)
    }

    static func modifierJS(namespace: JXNamespace) -> String? {
        return """
function(style) {
    const e = new \(JSCodeGenerator.elementClass)('\(ElementType.pickerStyleModifier.rawValue)');
    e.target = this;
    e.style = style;
    return e;
}
"""
    }
}
