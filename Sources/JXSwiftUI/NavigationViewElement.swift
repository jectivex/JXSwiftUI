import JXBridge
import JXKit
import SwiftUI

/// Vends a `SwiftUI.NavigationView`.
struct NavigationViewElement: Element {
    private let content: Content
    
    init(jxValue: JXValue) throws {
        self.content = try Content(jxValue: jxValue["content"])
    }

    var elementType: ElementType {
        return .navigationView
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
    const e = new \(namespace.value).JXElement('\(ElementType.navigationView.rawValue)');
    e.content = content;
    return e;
}
"""
    }
}

