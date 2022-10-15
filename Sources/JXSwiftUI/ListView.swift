import SwiftUI

protocol ListInfo: ElementInfo {
    var contentInfo: [ElementInfo] { get throws }
}

/// A view whose body is a `SwiftUI.List` view.
struct ListView: View {
    private let info: ListInfo

    init(_ info: ListInfo) {
        self.info = info
    }

    var body: some View {
        List {
            contentInfo.containerView
        }
    }

    private var contentInfo: [ElementInfo] {
        do {
            return try info.contentInfo
        } catch {
            // TODO: Error handling
            return []
        }
    }
}
