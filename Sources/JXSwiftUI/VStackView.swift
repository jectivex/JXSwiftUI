import SwiftUI

protocol VStackInfo: ElementInfo {
    var contentInfo: [ElementInfo] { get throws }
}

/// A view whose body is a `SwiftUI.VStack` view.
struct VStackView: View {
    let info: VStackInfo
    let errorHandler: ErrorHandler?

    var body: some View {
        VStack {
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
