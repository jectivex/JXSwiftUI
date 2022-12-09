import JXBridge
import JXKit
import SwiftUI

/// Vends a `SwiftUI.HStack` view.
struct HStackElement: Element {
    private let content: Content
    
    init(jxValue: JXValue) throws {
        self.content = try Content(jxValue: jxValue["content"])
    }

    func view(errorHandler: ErrorHandler?) -> any View {
        return HStack {
            let errorHandler = errorHandler?.in(.hstack)
            content.elementArray(errorHandler: errorHandler)
                .containerView(errorHandler: errorHandler)
        }
    }
    
    static func js(namespace: JXNamespace) -> String? {
        """
function(contentArray) {
    const e = new \(JXNamespace.default).\(JSCodeGenerator.elementClass)('\(ElementType.hstack.rawValue)');
    e.content = contentArray;
    return e;
}
"""
    }
}
