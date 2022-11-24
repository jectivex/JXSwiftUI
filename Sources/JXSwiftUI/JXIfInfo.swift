import JXKit

struct JXIfInfo: IfInfo {
    private let ifFunction: JXValue
    private let elseFunction: JXValue

    init(jxValue: JXValue) throws {
        self.isTrue = try jxValue["isTrue"].bool
        self.ifFunction = try jxValue["ifFunction"]
        self.elseFunction = try jxValue["elseFunction"]
    }

    var elementType: ElementType {
        return .if
    }

    let isTrue: Bool

    var ifContentInfo: ElementInfo {
        get throws {
            guard ifFunction.isFunction else {
                throw JXSwiftUIErrors.valueNotFunction(elementType.rawValue, "ifFunction")
            }
            let ifContent = try ifFunction.call(withArguments: [])
            return try JXElementInfo.info(for: ifContent, in: elementType)
        }
    }

    var elseContentInfo: ElementInfo? {
        get throws {
            guard !elseFunction.isUndefined else {
                return nil
            }
            guard elseFunction.isFunction else {
                throw JXSwiftUIErrors.valueNotFunction(elementType.rawValue, "elseFunction")
            }
            let elseContent = try elseFunction.call(withArguments: [])
            return try JXElementInfo.info(for: elseContent, in: elementType)
        }
    }
}
