import SwiftUI

protocol NavigationViewInfo: ElementInfo {
    var contentInfo: ElementInfo { get throws }
}

/// A view whose body is a `SwiftUI.NavigationView` view.
struct NavigationView: View {
    let info: NavigationViewInfo
    let errorHandler: ErrorHandler?

    var body: some View {
        SwiftUI.NavigationView {
            contentInfo.view(errorHandler: errorHandler)
        }
    }

    private var contentInfo: ElementInfo {
        do {
            return try info.contentInfo
        } catch {
            errorHandler?(error)
            return EmptyInfo()
        }
    }
}

