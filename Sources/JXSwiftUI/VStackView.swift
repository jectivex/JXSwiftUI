import JXKit
import SwiftUI

/// A view whose body is a `SwiftUI.VStack` view.
struct VStackView: View {
    let info: VStackInfo
    let errorHandler: ErrorHandler?

    var body: some View {
        VStack {
            info.contentInfo.containerView(errorHandler: errorHandler)
        }
    }
}

struct VStackInfo: ElementInfo {
    init(jxValue: JXValue) throws {
        self.contentInfo = try Self.infoArray(for: jxValue["content"], in: .vstack)
    }

    var elementType: ElementType {
        return .vstack
    }

    let contentInfo: [ElementInfo]
}
