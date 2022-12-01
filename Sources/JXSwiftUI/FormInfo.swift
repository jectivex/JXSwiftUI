import JXBridge
import JXKit
import SwiftUI

/// Vends a `SwiftUI.Form` view.
struct FormInfo: ElementInfo {
    private let contentInfo: [ElementInfo]
    
    init(jxValue: JXValue) throws {
        self.contentInfo = try Self.infoArray(for: jxValue["content"], in: .form)
    }

    var elementType: ElementType {
        return .form
    }
    
    @ViewBuilder
    func view(errorHandler: ErrorHandler?) -> any View {
        Form {
            contentInfo.containerView(errorHandler: errorHandler)
        }
    }
    
    static func js(namespace: JXNamespace) -> String? {
        """
function(contentArray) {
    const e = new \(namespace.value).JXElement('\(ElementType.form.rawValue)');
    e.content = contentArray;
    return e;
}
"""
    }
}
