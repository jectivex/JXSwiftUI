import JXBridge
import JXKit
import SwiftUI

/// Vends a `SwiftUI.NavigationView`.
struct NavigationViewElement: Element {
    private let content: Content
    
    init(jxValue: JXValue) throws {
        self.content = try Content(jxValue: jxValue["content"])
    }

    func view(errorHandler: ErrorHandler?) -> any View {
        return NavigationView {
            let errorHandler = errorHandler?.in(.navigationView)
            content.element(errorHandler: errorHandler)
                .view(errorHandler: errorHandler)
                .eraseToAnyView()
        }
    }
    
    static func js(namespace: JXNamespace) -> String? {
        """
function(content) {
    const e = new \(JXNamespace.default).\(JSCodeGenerator.elementClass)('\(ElementType.navigationView.rawValue)');
    e.content = content;
    return e;
}
"""
    }
}

