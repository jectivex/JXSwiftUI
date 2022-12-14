import JXBridge
import JXKit
import SwiftUI

extension JXSwiftUISupport {
    /// A `SwiftUI.Form`.
    ///
    /// Supported usage:
    ///
    ///     - Form([content])
    ///
    /// Supported `content`:
    ///
    ///     - View array
    ///     - Anonymous function returning a View array
    public enum Form {}
}

struct FormElement: Element {
    private let content: Content
    
    init(jxValue: JXValue) throws {
        self.content = try Content(jxValue: jxValue["content"])
    }

    func view(errorHandler: ErrorHandler) -> any View {
        return Form {
            let errorHandler = errorHandler.in(.form)
            content.elementArray(errorHandler: errorHandler)
                .containerView(errorHandler: errorHandler)
        }
    }
    
    static func js(namespace: JXNamespace) -> String? {
        """
function(contentArray) {
    const e = new \(JSCodeGenerator.elementClass)('\(ElementType.form.rawValue)');
    e.content = contentArray;
    return e;
}
"""
    }
}
