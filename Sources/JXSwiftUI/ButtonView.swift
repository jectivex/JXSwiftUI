import JXKit
import SwiftUI

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
        return info.contentInfo
    }

    private func onAction() {
        do {
            try info.onAction()
        } catch {
            errorHandler?(error)
        }
    }
}

struct ButtonInfo: ElementInfo {
    private let actionFunction: JXValue

    init(jxValue: JXValue) throws {
        self.contentInfo = try Self.info(for: jxValue["content"], in: .button)
        self.actionFunction = try jxValue["action"]
    }

    var elementType: ElementType {
        return .button
    }

    let contentInfo: ElementInfo

    func onAction() throws {
        try actionFunction.call(withArguments: [])
    }
}
