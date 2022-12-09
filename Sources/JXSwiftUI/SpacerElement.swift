import JXBridge
import JXKit
import SwiftUI

/// Vends a `SwiftUI.Spacer`.
struct SpacerElement: Element {
    init(jxValue: JXValue) throws {
    }

    func view(errorHandler: ErrorHandler?) -> any View {
        return Spacer()
    }
    
    static func js(namespace: JXNamespace) -> String? {
        """
function() {
    const e = new \(JXNamespace.default).\(JSCodeGenerator.elementClass)('\(ElementType.spacer.rawValue)');
    return e;
}
"""
    }
}
