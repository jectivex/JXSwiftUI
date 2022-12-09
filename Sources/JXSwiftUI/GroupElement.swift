import JXBridge
import JXKit
import SwiftUI

/// Vends a `SwiftUI.Group` view.
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
    const e = new \(namespace).JXElement('\(ElementType.group.rawValue)');
    e.content = contentArray;
    return e;
}
"""
    }
}