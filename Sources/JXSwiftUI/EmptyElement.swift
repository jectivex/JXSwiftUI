import JXBridge
import JXKit
import SwiftUI

/// Vends an empty view.
struct EmptyElement: Element {
    init(jxValue: JXValue) throws {
    }
    
    init() {
    }
    
    func view(errorHandler: ErrorHandler?) -> any View {
        return EmptyView()
    }
    
    static func js(namespace: JXNamespace) -> String? {
"""
function() {
    return new \(JXNamespace.default).\(JSCodeGenerator.elementClass)('\(ElementType.empty.rawValue)');
}
"""
    }
}
