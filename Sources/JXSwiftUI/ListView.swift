import JXKit
import SwiftUI

/// A view whose body is a `SwiftUI.List` view.
struct ListView: View {
    let info: ListInfo
    let errorHandler: ErrorHandler?

    var body: some View {
        List {
            info.contentInfo.containerView(errorHandler: errorHandler)
        }
    }
}

struct ListInfo: ElementInfo {
    init(jxValue: JXValue) throws {
        self.contentInfo = try Self.infoArray(for: jxValue["content"], in: .list)
    }

    var elementType: ElementType {
        return .list
    }

    let contentInfo: [ElementInfo]
}
