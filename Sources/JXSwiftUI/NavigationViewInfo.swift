import JXBridge
import JXKit
import SwiftUI

/// Vends a `SwiftUI.NavigationView`.
struct NavigationViewInfo: ElementInfo {
    private let contentInfo: ElementInfo
    
    init(jxValue: JXValue) throws {
        self.contentInfo = try Self.info(for: jxValue["content"], in: .navigationView)
    }

    var elementType: ElementType {
        return .navigationView
    }

    @ViewBuilder
    func view(errorHandler: ErrorHandler?) -> any View {
        NavigationView {
            AnyView(contentInfo.view(errorHandler: errorHandler))
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

