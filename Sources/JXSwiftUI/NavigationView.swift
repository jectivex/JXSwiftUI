import JXKit
import SwiftUI

/// A view whose body is a `SwiftUI.NavigationView` view.
struct NavigationView: View {
    let info: NavigationViewInfo
    let errorHandler: ErrorHandler?

    var body: some View {
        SwiftUI.NavigationView {
            info.contentInfo.view(errorHandler: errorHandler)
        }
    }
}

struct NavigationViewInfo: ElementInfo {
    init(jxValue: JXValue) throws {
        self.contentInfo = try Self.info(for: jxValue["content"], in: .navigationView)
    }

    var elementType: ElementType {
        return .navigationView
    }

    let contentInfo: ElementInfo
}

