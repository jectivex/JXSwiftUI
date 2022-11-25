import JXKit
import SwiftUI

/// Vends a `SwiftUI.List`.
struct ListInfo: ElementInfo {
    private let contentInfo: [ElementInfo]
    
    init(jxValue: JXValue) throws {
        self.contentInfo = try Self.infoArray(for: jxValue["content"], in: .list)
    }

    var elementType: ElementType {
        return .list
    }

    @ViewBuilder
    func view(errorHandler: ErrorHandler?) -> any View {
        List {
            contentInfo.containerView(errorHandler: errorHandler)
        }
    }
}
