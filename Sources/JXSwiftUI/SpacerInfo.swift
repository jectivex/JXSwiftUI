import JXBridge
import JXKit
import SwiftUI

/// Vends a `SwiftUI.Spacer`.
struct SpacerInfo: ElementInfo {
    init(jxValue: JXValue) throws {
    }

    var elementType: ElementType {
        return .spacer
    }
    
    @ViewBuilder
    func view(errorHandler: ErrorHandler?) -> any View {
        Spacer()
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
