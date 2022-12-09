import JXBridge
import JXKit
import SwiftUI

/// Sets a foreground color on its target view.
struct ForegroundColorModifier: Element {
    private let target: Content
    private let color: Color
    
    init(jxValue: JXValue) throws {
        self.target = try Content(jxValue: jxValue["target"])
        self.color = try jxValue["color"].convey()
    }

    func view(errorHandler: ErrorHandler?) -> any View {
        return target.element(errorHandler: errorHandler)
            .view(errorHandler: errorHandler)
            .foregroundColor(color)
    }
    
    static func modifierJS(namespace: JXNamespace) -> String? {
        // .foregroundColor(Color) or .foregroundColor('name')
        return """
function(color) {
    const e = new \(JXNamespace.default).\(JSCodeGenerator.elementClass)('\(ElementType.foregroundColorModifier.rawValue)');
    e.target = this;
    if (typeof(color) === 'string') {
        e.color = new swiftui.Color(color);
    } else {
        e.color = color;
    }
    return e;
}
"""
    }
}
