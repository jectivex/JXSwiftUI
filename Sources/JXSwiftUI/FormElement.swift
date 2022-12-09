import JXBridge
import JXKit
import SwiftUI

/// Vends a `SwiftUI.Form` view.
struct FormElement: Element {
    private let content: Content
    
    init(jxValue: JXValue) throws {
        self.content = try Content(jxValue: jxValue["content"])
    }

    func view(errorHandler: ErrorHandler?) -> any View {
        return Form {
            let errorHandler = errorHandler?.in(.form)
            content.elementArray(errorHandler: errorHandler)
                .containerView(errorHandler: errorHandler)
        }
    }
    
    static func js(namespace: JXNamespace) -> String? {
        """
function(contentArray) {
    const e = new \(JXNamespace.default).\(JSCodeGenerator.elementClass)('\(ElementType.form.rawValue)');
    e.content = contentArray;
    return e;
}
"""
    }
}
