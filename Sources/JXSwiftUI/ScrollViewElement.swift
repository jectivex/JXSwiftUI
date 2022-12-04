import JXBridge
import JXKit
import SwiftUI

/// Vends a `SwiftUI.ScrollView` view.
struct ScrollViewElement: Element {
    private let content: Content
    
    init(jxValue: JXValue) throws {
        self.content = try Content(jxValue: jxValue["content"])
    }

    func view(errorHandler: ErrorHandler?) -> any View {
        return ScrollView {
            let errorHandler = errorHandler?.in(.scrollView)
            content.element(errorHandler: errorHandler)
                .view(errorHandler: errorHandler)
                .eraseToAnyView()
        }
    }
    
    static func js(namespace: JXNamespace) -> String? {
        """
function(content) {
    const e = new \(namespace).JXElement('\(ElementType.scrollView.rawValue)');
    e.content = content;
    return e;
}
"""
    }
}
