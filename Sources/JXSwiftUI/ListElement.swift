import JXBridge
import JXKit
import SwiftUI

/// Vends a `SwiftUI.List`.
struct ListElement: Element {
    private let content: Content
    
    init(jxValue: JXValue) throws {
        self.content = try Content(jxValue: jxValue["content"])
    }

    func view(errorHandler: ErrorHandler?) -> any View {
        return List {
            let errorHandler = errorHandler?.in(.list)
            content.elementArray(errorHandler: errorHandler) .containerView(errorHandler: errorHandler)
        }
    }
    
    static func js(namespace: JXNamespace) -> String? {
        """
function(contentArray) {
    const e = new \(namespace).JXElement('\(ElementType.list.rawValue)');
    e.content = contentArray;
    return e;
}
"""
    }
}
