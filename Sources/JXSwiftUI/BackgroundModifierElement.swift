import JXBridge
import JXKit
import SwiftUI

/// Sets a background its target view.
struct BackgroundModifierElement: Element {
    private let target: Content
    private let content: Content
    
    init(jxValue: JXValue) throws {
        self.target = try Content(jxValue: jxValue["target"])
        self.content = try Content(jxValue: jxValue["content"])
    }

    func view(errorHandler: ErrorHandler?) -> any View {
        let backgroundErrorHandler = errorHandler?.in(.backgroundModifier)
        return target.element(errorHandler: errorHandler)
            .view(errorHandler: errorHandler)
            .background(content.element(errorHandler: backgroundErrorHandler).view(errorHandler: backgroundErrorHandler))
    }
    
    static func modifierJS(namespace: JXNamespace) -> String? {
        return """
function(content) {
    const e = new \(namespace).JXElement('\(ElementType.backgroundModifier.rawValue)');
    e.target = this;
    if (typeof(color) === 'string') {
        e.content = new swiftui.Color(color);
    } else {
        e.content = content;
    }
    return e;
}
"""
    }
}
