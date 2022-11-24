import SwiftUI

protocol HStackInfo: ElementInfo {
    var contentInfo: [ElementInfo] { get throws }
}

/// A view whose body is a `SwiftUI.HStack` view.
struct HStackView: View {
    let info: HStackInfo
    let errorHandler: ErrorHandler?

    var body: some View {
        HStack {
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
