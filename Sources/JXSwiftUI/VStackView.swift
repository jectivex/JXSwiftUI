import SwiftUI

protocol VStackInfo: ElementInfo {
    var contentInfo: [ElementInfo] { get throws }
}

/// A view whose body is a `SwiftUI.VStack` view.
struct VStackView: View {
    private let info: VStackInfo

    init(_ info: VStackInfo) {
        self.info = info
    }

    var body: some View {
        VStack {
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
