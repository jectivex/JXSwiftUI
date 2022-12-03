import JXBridge
import JXKit
import SwiftUI

/// Vends a `SwiftUI.Spacer`.
struct SpacerElement: Element {
    init(jxValue: JXValue) throws {
    }

    var elementType: ElementType {
        return .spacer
    }
    
    func view(errorHandler: ErrorHandler?) -> any View {
        return Spacer()
    }
    
    static func js(namespace: JXNamespace) -> String? {
        """
function() {
    const e = new \(namespace.value).JXElement('\(ElementType.spacer.rawValue)');
    return e;
}
"""
    }
}
