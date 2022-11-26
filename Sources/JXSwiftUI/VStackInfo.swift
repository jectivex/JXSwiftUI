import JXKit
import SwiftUI

/// Vends a `SwiftUI.VStack`.
struct VStackInfo: ElementInfo {
    private let contentInfo: [ElementInfo]
    
    init(jxValue: JXValue) throws {
        self.contentInfo = try Self.infoArray(for: jxValue["content"], in: .vstack)
    }

    var elementType: ElementType {
        return .vstack
    }

    func view(errorHandler: ErrorHandler?) -> any View {
        VStack {
            contentInfo.containerView(errorHandler: errorHandler)
        }
    }
}
