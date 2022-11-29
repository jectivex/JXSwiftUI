import JXBridge
import JXKit
import SwiftUI

/// Vends a `SwiftUI.HStack` view.
struct HStackInfo: ElementInfo {
    private let contentInfo: [ElementInfo]
    
    init(jxValue: JXValue) throws {
        self.contentInfo = try Self.infoArray(for: jxValue["content"], in: .hstack)
    }

    var elementType: ElementType {
        return .hstack
    }
    
    @ViewBuilder
    func view(errorHandler: ErrorHandler?) -> any View {
        HStack {
            contentInfo.containerView(errorHandler: errorHandler)
        }
    }
    
    static func js(namespace: JXNamespace) -> String? {
        """
function(content) {
    const e = new \(namespace.value).JXElement('\(ElementType.hstack.rawValue)');
    e.content = content;
    return e;
}
"""
    }
}
