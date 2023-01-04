import JXBridge
import JXKit
import SwiftUI

extension JXSwiftUISupport {
    /// Sets the list style on a target view.
    ///
    /// Supported calls:
    ///
    ///     - .listStyle(ListStyle)
    ///     - .listStyle(ListStyle, {props})
    ///
    /// Supported `props`:
    ///
    ///     - alternatesRowBackgrounds: Bool
    public enum listStyle {}

    /// Use a JavaScript string to name any standard `SwiftUI.ListStyle` value, e.g. `'automatic'`.
    public enum ListStyle {}
}

struct ListStyleModifier: Element {
    private let target: Content
    private let style: any ListStyle

    init(jxValue: JXValue) throws {
        self.target = try Content(jxValue: jxValue["target"])
        let styleString = try jxValue["style"].string
        switch styleString {
        case "automatic":
            self.style = .automatic
#if os(macOS)
        case "bordered":
            let propsValue = try jxValue["props"]
            let alternates = try !propsValue.isUndefined && propsValue["alternatesRowBackgrounds"].bool
            self.style = .bordered(alternatesRowBackgrounds: alternates)
#endif
#if !os(macOS)
        case "grouped":
            self.style = .grouped
        case "insetGrouped":
            self.style = .insetGrouped
#endif
        case "inset":
#if os(macOS)
            let propsValue = try jxValue["props"]
            let alternates = try !propsValue.isUndefined && propsValue["alternatesRowBackgrounds"].bool
            self.style = .inset(alternatesRowBackgrounds: alternates)
#else
            self.style = .inset
#endif
        case "plain":
            self.style = .plain
        case "sidebar":
            self.style = .sidebar
        default:
            throw JXError.invalid(value: styleString, for: (any ListStyle).self)
        }
    }

    func view(errorHandler: ErrorHandler) -> any View {
        return target.element(errorHandler: errorHandler)
            .view(errorHandler: errorHandler)
            .listStyle(style)
    }

    static func modifierJS(namespace: JXNamespace) -> String? {
        return """
function(style, props) {
    const e = new \(JSCodeGenerator.elementClass)('\(ElementType.listStyleModifier.rawValue)');
    e.target = this;
    e.style = style;
    e.props = props;
    return e;
}
"""
    }
}
