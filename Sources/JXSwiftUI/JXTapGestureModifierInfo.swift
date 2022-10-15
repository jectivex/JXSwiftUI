import JXKit

struct JXTapGestureModifierInfo: TapGestureModifierInfo {
    private let onTapFunction: JXValue

    init(jxValue: JXValue) throws {
        self.targetInfo = try JXElementInfo.info(for: jxValue["target"], in: "onTapGesture")
        self.onTapFunction = try jxValue["action"]
    }

    var elementType: ElementType {
        return .tapGestureModifier
    }

    let targetInfo: ElementInfo

    func onTapGesture() throws {
        try onTapFunction.call(withArguments: [])
    }
}
