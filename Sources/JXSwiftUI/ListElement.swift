import JXBridge
import JXKit
import SwiftUI

extension JXSwiftUISupport {
    /// A `SwiftUI.List`.
    ///
    /// Supported usage:
    ///
    ///     - List([content])
    ///
    /// Supported `content`:
    ///
    ///     - View array
    ///     - Anonymous function returning a View array
    public enum List {}
}

// TODO: Support List selection, editing, row generation
// TODO: Support .listStyle modifier for at least the standard styles

struct ListElement: Element {
    private let content: Content
    
    init(jxValue: JXValue) throws {
        self.content = try Content(jxValue: jxValue["content"])
    }

    func view(errorHandler: ErrorHandler) -> any View {
        return List {
            let errorHandler = errorHandler.in(.list)
            content.elementArray(errorHandler: errorHandler)
                .containerView(errorHandler: errorHandler)
        }
    }
    
    static func js(namespace: JXNamespace) -> String? {
        """
function(contentArray) {
    const e = new \(JSCodeGenerator.elementClass)('\(ElementType.list.rawValue)');
    e.content = contentArray;
    return e;
}
"""
    }
}
