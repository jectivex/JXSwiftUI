import JXBridge
import JXKit
import SwiftUI

/// Sets a font on its target view.
struct FontModifier: Element {
    private let target: Content
    private let font: Font
    
    init(jxValue: JXValue) throws {
        self.target = try Content(jxValue: jxValue["target"])
        self.font = try jxValue["font"].convey()
    }

    func view(errorHandler: ErrorHandler?) -> any View {
        return target.element(errorHandler: errorHandler)
            .view(errorHandler: errorHandler)
            .font(font)
    }
    
    static func modifierJS(namespace: JXNamespace) -> String? {
        // .font(Font) or .font('name')
        return """
function(font) {
    const e = new \(JXNamespace.default).\(JSCodeGenerator.elementClass)('\(ElementType.fontModifier.rawValue)');
    e.target = this;
    if (typeof(font) === 'string') {
        e.font = swiftui.Font.system(font)
    } else {
        e.font = font;
    }
    return e;
}
"""
    }
}
