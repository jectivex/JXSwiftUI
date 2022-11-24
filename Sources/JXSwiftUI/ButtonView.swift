import SwiftUI

protocol ButtonInfo: ElementInfo {
    var contentInfo: ElementInfo { get throws }
    func onAction() throws
}

/// A view whose body is a `SwiftUI.Button` view.
struct ButtonView: View {
    let info: ButtonInfo
    let errorHandler: ErrorHandler?

    var body: some View {
        Button(action: onAction) {
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

    private func onAction() {
        do {
            try info.onAction()
        } catch {
            errorHandler?(error)
        }
    }
}
