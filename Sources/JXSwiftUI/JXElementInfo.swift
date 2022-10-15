import JXKit

// TODO: Fix error handling throughout this framework to throw

struct JXElementInfo: ElementInfo {
    let elementType: ElementType

    static func `for`(_ jxValue: JXValue) throws -> ElementInfo? {
        let elementTypeString = try jxValue[JSCodeGenerator.elementTypeProperty].string
        let elementType = ElementType(rawValue: elementTypeString) ?? .unknown
        switch elementType {
        case .button:
            return try JXButtonInfo(jxValue: jxValue)
        case .custom:
            return try JXCustomInfo(jxValue: jxValue)
        case .empty:
            return EmptyInfo()
        case .foreach:
            return try JXForEachInfo(jxValue: jxValue)
        case .hstack:
            return try JXHStackInfo(jxValue: jxValue)
        case .if:
            return try JXIfInfo(jxValue: jxValue)
        case .list:
            return try JXListInfo(jxValue: jxValue)
        case .spacer:
            return try JXSpacerInfo(jxValue: jxValue)
        case .text:
            return try JXTextInfo(jxValue: jxValue)
        case .vstack:
            return try JXVStackInfo(jxValue: jxValue)

        case .fontModifier:
            return try JXFontModifierInfo(jxValue: jxValue)
        case .tapGestureModifier:
            return try JXTapGestureModifierInfo(jxValue: jxValue)
        case .unknown:
            return nil
        }
    }

    static func info(for jxValue: JXValue, in elementName: String) throws -> ElementInfo {
        guard !jxValue.isUndefined else {
            // TODO: Throw informative error
            return EmptyInfo()
        }
        guard let elementInfo = try self.for(jxValue) else {
            // TODO: Throw informative error
            return EmptyInfo()
        }
        return elementInfo
    }

    static func infoArray(for jxValue: JXValue, in elementName: String) throws -> [ElementInfo] {
        guard !jxValue.isUndefined else {
            // TODO: Throw informative error
            return []
        }
        guard jxValue.isArray else {
            // TODO: Throw informative error
            return []
        }
        let contentArray = try jxValue.array
        return try (0 ..< contentArray.count).map { i in
            return try info(for: contentArray[i], in: elementName)
        }
    }
}
