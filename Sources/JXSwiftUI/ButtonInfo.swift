import JXKit
import SwiftUI

/// Vends a `SwiftUI.Button`.
struct ButtonInfo: ElementInfo {
    private let contentInfo: ElementInfo
    private let actionFunction: JXValue

    init(jxValue: JXValue) throws {
        self.contentInfo = try Self.info(for: jxValue["content"], in: .button)
        self.actionFunction = try jxValue["action"]
    }

    var elementType: ElementType {
        return .button
    }
    
    @ViewBuilder
    func view(errorHandler: ErrorHandler?) -> any View {
        Button(action: { onAction(errorHandler: errorHandler) }) {
            AnyView(contentInfo.view(errorHandler: errorHandler))
        }
    }
    
    private func onAction(errorHandler: ErrorHandler?) {
        do {
            try actionFunction.call(withArguments: [])
        } catch {
            errorHandler?(error)
        }
    }
}
