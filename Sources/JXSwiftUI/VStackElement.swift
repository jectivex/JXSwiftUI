import JXBridge
import JXKit
import SwiftUI

/// Vends a `SwiftUI.VStack`.
struct VStackElement: Element {
    private let content: Content
    
    init(jxValue: JXValue) throws {
        self.content = try Content(jxValue: jxValue["content"])
    }

    func view(errorHandler: ErrorHandler?) -> any View {
        return VStack {
            let errorHandler = errorHandler?.in(.vstack)
            content.elementArray(errorHandler: errorHandler)
                .containerView(errorHandler: errorHandler)
        }
    }
    
    static func js(namespace: JXNamespace) -> String? {
        """
function(contentArray) {
    const e = new \(namespace).JXElement('\(ElementType.vstack.rawValue)');
    e.content = contentArray;
    return e;
}
"""
    }
}
