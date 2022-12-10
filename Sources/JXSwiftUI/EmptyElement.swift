import JXBridge
import JXKit
import SwiftUI

extension JXSupported {
    /// A `SwiftUI.EmptyView`.
    /// Supported usage:
    ///
    ///     - EmptyView()
    public struct EmptyView {}
}

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
