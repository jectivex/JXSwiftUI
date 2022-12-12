import JXBridge
import JXKit
import SwiftUI

extension JXSwiftUISupport {
    /// Sets a navigation title on a target view.
    /// Supported calls:
    ///
    ///     - .navigationTitle('title')
    ///     - .navigationTitle(Text)
    public enum navigationTitle {}
}

struct NavigationTitleModifier: Element {
    private let target: Content
    private let title: Content
    
    init(jxValue: JXValue) throws {
        self.target = try Content(jxValue: jxValue["target"])
        self.title = try Content(jxValue: jxValue["title"])
    }

    func view(errorHandler: ErrorHandler?) -> any View {
        let targetView = target.element(errorHandler: errorHandler)
            .view(errorHandler: errorHandler)
        let titleErrorHandler = errorHandler?.in(.navigationTitleModifier)
        guard let titleText = title.element(errorHandler: titleErrorHandler)
            .view(errorHandler: titleErrorHandler) as? Text else {
            titleErrorHandler?.handle(JXError(message: "Expected a string or Text view"))
            return targetView
        }
        return targetView.navigationTitle(titleText)
    }
    
    static func modifierJS(namespace: JXNamespace) -> String? {
        return """
function(title) {
    const e = new \(JXNamespace.default).\(JSCodeGenerator.elementClass)('\(ElementType.navigationTitleModifier.rawValue)');
    e.target = this;
    e.title = title;
    return e;
}
"""
    }
}
