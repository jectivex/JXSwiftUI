import SwiftUI

protocol ListInfo: ElementInfo {
    var contentInfo: [ElementInfo] { get throws }
}

/// A view whose body is a `SwiftUI.List` view.
struct ListView: View {
    let info: ListInfo
    let errorHandler: ErrorHandler?

    var body: some View {
        List {
            contentInfo.containerView(errorHandler: errorHandler)
        }
    }

    private var contentInfo: [ElementInfo] {
        do {
            return try info.contentInfo
        } catch {
            errorHandler?(error)
            return []
        }
    }
}
