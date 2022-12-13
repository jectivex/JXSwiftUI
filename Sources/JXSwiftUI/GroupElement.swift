import JXBridge
import JXKit
import SwiftUI

extension JXSwiftUISupport {
    /// A `SwiftUI.Group`.
    /// Supported usage:
    ///
    ///     - Group([content])
    ///
    /// Supported content:
    ///
    ///     - View array
    ///     - Anonymous function returning a View array
    public enum Group {}
}

struct GroupElement: Element {
    private let content: Content
    
    init(jxValue: JXValue) throws {
        self.content = try Content(jxValue: jxValue["content"])
    }

    func view(errorHandler: ErrorHandler?) -> any View {
        let errorHandler = errorHandler?.in(.group)
        // .containerView already wraps its views in a Group
        return content.elementArray(errorHandler: errorHandler)
            .containerView(errorHandler: errorHandler)
    }
    
    static func js(namespace: JXNamespace) -> String? {
        """
function(contentArray) {
    const e = new \(JXNamespace.default).\(JSCodeGenerator.elementClass)('\(ElementType.group.rawValue)');
    e.content = contentArray;
    return e;
}
"""
    }
}
