import JXBridge
import SwiftUI

/// Vends an empty view.
struct EmptyInfo: ElementInfo {
    var elementType: ElementType {
        return .empty
    }
    
    @ViewBuilder
    func view(errorHandler: ErrorHandler?) -> any View {
        EmptyView()
    }
    
    static func js(namespace: JXNamespace) -> String? {
"""
function() {
    return new \(namespace.value).JXElement('\(ElementType.empty.rawValue)');
}
"""
    }
}
