import JXKit

struct JXButtonInfo: ButtonInfo {
    private let actionFunction: JXValue

    init(jxValue: JXValue) throws {
        self.contentInfo = try JXElementInfo.info(for: jxValue["content"], in: "Button")
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
