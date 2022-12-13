import JXBridge
import JXKit
import SwiftUI

extension JXSwiftUISupport {
    /// Sets a font on a target view.
    /// 
    /// Supported calls:
    ///
    ///     - .font(FontTextStyle)
    ///     - .font(Font)
    public enum font {}
}

struct FontModifier: Element {
    private let target: Content
    private let font: Font
    
    init(jxValue: JXValue) throws {
        self.target = try Content(jxValue: jxValue["target"])
        let fontValue = try jxValue["font"]
        if fontValue.isString {
            let style = try fontValue.convey(to: Font.TextStyle.self)
            self.font = Font.system(style)
        } else {
            self.font = try fontValue.convey()
        }
    }

    func view(errorHandler: ErrorHandler) -> any View {
        return target.element(errorHandler: errorHandler)
            .view(errorHandler: errorHandler)
            .font(font)
    }
    
    static func modifierJS(namespace: JXNamespace) -> String? {
        return """
function(font) {
    const e = new \(JXNamespace.default).\(JSCodeGenerator.elementClass)('\(ElementType.fontModifier.rawValue)');
    e.target = this;
    e.font = font;
    return e;
}
"""
    }
}
