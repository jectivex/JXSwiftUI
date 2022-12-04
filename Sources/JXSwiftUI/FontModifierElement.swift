import JXBridge
import JXKit
import SwiftUI

/// Sets a font on its target view.
struct FontModifierElement: Element {
    private let target: Content
    private let font: Font
    
    init(jxValue: JXValue) throws {
        self.target = try Content(jxValue: jxValue["target"])
        let fontName = try jxValue["fontName"].string
        self.font = try Self.font(for: fontName)
    }

    var elementType: ElementType {
        return .fontModifier
    }

    func view(errorHandler: ErrorHandler?) -> any View {
        return target.element(errorHandler: errorHandler)
            .view(errorHandler: errorHandler)
            .font(font)
    }
    
    static func js(namespace: JXNamespace) -> String? {
        """
function(target, fontName) {
    const e = new \(namespace.value).JXElement('\(ElementType.fontModifier.rawValue)');
    e.target = target;
    e.fontName = fontName;
    return e;
}
"""
    }
    
    static func modifierJS(for modifier: String, namespace: JXNamespace) -> String? {
        guard modifier == "font" else {
            return nil
        }
        return """
function(fontName) {
    return \(namespace.value).\(ElementType.fontModifier.rawValue)(this, fontName);
}
"""
    }

    private static func font(for fontString: String) throws -> Font {
        switch fontString {
        case "title":
            return .title
        case "body":
            return .body
        case "caption":
            return .caption
        default:
            throw JXError(message: "Unsupported font '\(fontString)'")
        }
    }
}
