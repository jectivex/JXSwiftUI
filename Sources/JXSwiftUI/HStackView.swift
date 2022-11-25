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
    
    func view(errorHandler: ErrorHandler?) -> any View {
        HStack {
            contentInfo.containerView(errorHandler: errorHandler)
        }
    }
}
