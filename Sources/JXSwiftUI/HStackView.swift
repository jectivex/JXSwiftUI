import JXKit
import SwiftUI

/// A view whose body is a `SwiftUI.HStack` view.
struct HStackView: View {
    let info: HStackInfo
    let errorHandler: ErrorHandler?

    var body: some View {
        HStack {
            info.contentInfo.containerView(errorHandler: errorHandler)
        }
    }
}

struct HStackInfo: ElementInfo {
    init(jxValue: JXValue) throws {
        self.contentInfo = try Self.infoArray(for: jxValue["content"], in: .hstack)
    }

    var elementType: ElementType {
        return .hstack
    }

    let contentInfo: [ElementInfo]
}
