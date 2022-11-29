import JXBridge
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
    
    static func js(namespace: JXNamespace) -> String? {
"""
function(actionOrLabel, actionOrContent) {
    const e = new \(namespace.value).JXElement('\(ElementType.button.rawValue)');
    // Button('label', () => { action }) or Button(() => { action }, <content>)
    if (typeof(actionOrLabel) === 'string') {
        e.action = actionOrContent;
        e.content = \(namespace.value).Text(actionOrLabel);
    } else {
        e.action = actionOrLabel;
        e.content = actionOrContent;
    }
    return e;
}
"""
    }
    
    private func onAction(errorHandler: ErrorHandler?) {
        do {
            try actionFunction.call(withArguments: [])
        } catch {
            errorHandler?(error)
        }
    }
}
