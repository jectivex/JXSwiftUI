import JXBridge
import SwiftUI

/// Vends an empty view.
struct EmptyElement: Element {
    var elementType: ElementType {
        return .empty
    }
    
    func view(errorHandler: ErrorHandler?) -> any View {
        return EmptyView()
    }
    
    static func js(namespace: JXNamespace) -> String? {
"""
function() {
    return new \(namespace.value).JXElement('\(ElementType.empty.rawValue)');
}
"""
    }
}
