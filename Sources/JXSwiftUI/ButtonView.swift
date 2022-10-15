import SwiftUI

protocol ButtonInfo: ElementInfo {
    var contentInfo: ElementInfo { get throws }
    func onAction() throws
}

/// A view whose body is a `SwiftUI.Button` view.
struct ButtonView: View {
    private let info: ButtonInfo

    init(_ info: ButtonInfo) {
        self.info = info
    }

    var body: some View {
        Button(action: onAction) {
            contentInfo.view
        }
    }

    private var contentInfo: ElementInfo {
        do {
            return try info.contentInfo
        } catch {
            // TODO: Error handling
            return EmptyInfo()
        }
    }

    private func onAction() {
        do {
            try info.onAction()
        } catch {
            // TODO: Error handling
        }
    }
}
