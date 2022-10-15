import SwiftUI

protocol HStackInfo: ElementInfo {
    var contentInfo: [ElementInfo] { get throws }
}

/// A view whose body is a `SwiftUI.HStack` view.
struct HStackView: View {
    private let info: HStackInfo

    init(_ info: HStackInfo) {
        self.info = info
    }

    var body: some View {
        HStack {
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
