import JXBridge
import JXKit
import SwiftUI

extension JXSwiftUISupport {
    /// Sets a border on a target view.
    ///
    /// Supported calls:
    ///
    ///     - .border({props}, content)
    ///     - .border(content)
    ///
    /// Supported `props`:
    ///
    ///     - width: Number
    ///
    /// Supported `content`:
    ///
    ///     - Color name
    ///     - View
    ///     - Anonymous function returning a View
    public enum border {}
}

struct BorderModifier: Element {
    private let target: Content
    private let width: CGFloat
    private let content: Content

    init(jxValue: JXValue) throws {
        self.target = try Content(jxValue: jxValue["target"])
        let widthValue = try jxValue["width"]
        self.width = try widthValue.isUndefined ? 1.0 : widthValue.double
        let contentValue = try jxValue["content"]
        if contentValue.isString {
            self.content = try Content(view: Color(contentValue.string))
        } else {
            self.content = try Content(jxValue: contentValue)
        }
    }

    func view(errorHandler: ErrorHandler) -> any View {
        let targetView = target.element(errorHandler: errorHandler)
            .view(errorHandler: errorHandler)
        let borderErrorHandler = errorHandler.in(.borderModifier)
        let contentView = content.element(errorHandler: borderErrorHandler)
            .view(errorHandler: borderErrorHandler)
        guard let shapeStyle = contentView as? any ShapeStyle else {
            borderErrorHandler.handle(JXError(message: "Content must conform to 'ShapeStyle'"))
            return targetView
        }
        return targetView.border(shapeStyle, width: width)
    }

    static func modifierJS(namespace: JXNamespace) -> String? {
        return """
function(propsOrContent, content) {
    const e = new \(JSCodeGenerator.elementClass)('\(ElementType.borderModifier.rawValue)');
    e.target = this;
    if (content === undefined) {
        e.content = propsOrContent;
    } else {
        e.width = propsOrContent.width;
        e.content = content;
    }
    return e;
}
"""
    }
}
