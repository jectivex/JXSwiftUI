import JXKit

struct JXTapGestureModifierInfo: TapGestureModifierInfo {
    private let onTapFunction: JXValue

    init(jxValue: JXValue) throws {
        self.targetInfo = try JXElementInfo.info(for: jxValue["target"], in: .tapGestureModifier)
        self.onTapFunction = try jxValue["action"]
    }

    var elementType: ElementType {
        return .tapGestureModifier
    }

    let targetInfo: ElementInfo

    func onTapGesture() throws {
        guard onTapFunction.isFunction else {
            throw JXSwiftUIErrors.valueNotFunction(elementType.rawValue, "action")
        }
        try onTapFunction.call(withArguments: [])
    }
}
