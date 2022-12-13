import JXBridge
import JXKit
import SwiftUI

extension JXSwiftUISupport {
    /// Sets a background on a target view.
    /// 
    /// Supported calls:
    ///
    ///     - .background({props}, content)
    ///     - .background(content)
    ///
    /// Supported `props`:
    ///
    ///     - alignment: Alignment
    ///
    /// Supported `content`:
    ///
    ///     - Color name
    ///     - View
    ///     - Anonymous function returning a View
    public enum background {}
}

struct BackgroundModifier: Element {
    private let target: Content
    private let alignment: Alignment
    private let content: Content
    
    init(jxValue: JXValue) throws {
        self.target = try Content(jxValue: jxValue["target"])
        let alignmentValue = try jxValue["alignment"]
        self.alignment = try alignmentValue.isUndefined ? .center : alignmentValue.convey()
        let contentValue = try jxValue["content"]
        if contentValue.isString {
            self.content = try Content(view: Color(contentValue.string))
        } else {
            self.content = try Content(jxValue: contentValue)
        }
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
        return """
function(propsOrContent, content) {
    const e = new \(JXNamespace.default).\(JSCodeGenerator.elementClass)('\(ElementType.backgroundModifier.rawValue)');
    e.target = this;
    if (content === undefined) {
        e.content = propsOrContent;
    } else {
        e.alignment = propsOrContent.alignment;
        e.content = content;
    }
    return e;
}
"""
    }
}
