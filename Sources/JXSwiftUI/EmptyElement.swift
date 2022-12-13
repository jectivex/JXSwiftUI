import JXBridge
import JXKit
import SwiftUI

extension JXSwiftUISupport {
    /// A `SwiftUI.EmptyView`.
    /// 
    /// Supported usage:
    ///
    ///     - EmptyView()
    public enum EmptyView {}
}

struct EmptyElement: Element {
    init(jxValue: JXValue) throws {
    }
    
    init() {
    }
    
    func view(errorHandler: ErrorHandler) -> any View {
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
