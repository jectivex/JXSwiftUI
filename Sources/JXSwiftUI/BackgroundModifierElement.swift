import JXBridge
import JXKit
import SwiftUI

/// Sets a background its target view.
struct BackgroundModifierElement: Element {
    private let target: Content
    private let alignment: Alignment
    private let content: Content
    
    init(jxValue: JXValue) throws {
        self.target = try Content(jxValue: jxValue["target"])
        self.alignment = try jxValue["alignment"].convey()
        self.content = try Content(jxValue: jxValue["content"])
    }

    func view(errorHandler: ErrorHandler?) -> any View {
        let backgroundErrorHandler = errorHandler?.in(.backgroundModifier)
        return target.element(errorHandler: errorHandler)
            .view(errorHandler: errorHandler)
            .background(alignment: alignment) {
                content.element(errorHandler: backgroundErrorHandler)
                    .view(errorHandler: backgroundErrorHandler)
                    .eraseToAnyView()
            }
    }
    
    static func modifierJS(namespace: JXNamespace) -> String? {
        // .background(props, content) or .background(content), where content may be a color name
        return """
function(propsOrContent, content) {
    const e = new \(namespace).JXElement('\(ElementType.backgroundModifier.rawValue)');
    e.target = this;
    if (content === undefined) {
        e.alignment = 'center';
        if (typeof(propsOrContent) === 'string') {
            e.content = new swiftui.Color(propsOrContent);
        } else {
            e.content = propsOrContent;
        }
    } else {
        e.alignment = (propsOrContent.alignment === undefined) ? 'center' : propsOrContent.alignment;
        if (typeof(content) === 'string') {
            e.content = new swiftui.Color(content);
        } else {
            e.content = content;
        }
    }
    return e;
}
"""
    }
}
