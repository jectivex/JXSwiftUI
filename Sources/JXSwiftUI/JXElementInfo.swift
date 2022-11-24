import JXKit

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
        case .navigationView:
            return try JXNavigationViewInfo(jxValue: jxValue)
        case .spacer:
            return try JXSpacerInfo(jxValue: jxValue)
        case .text:
            return try JXTextInfo(jxValue: jxValue)
        case .vstack:
            return try JXVStackInfo(jxValue: jxValue)

        case .fontModifier:
            return try JXFontModifierInfo(jxValue: jxValue)
        case .navigationTitleModifier:
            return try JXNavigationTitleModifierInfo(jxValue: jxValue)
        case .tapGestureModifier:
            return try JXTapGestureModifierInfo(jxValue: jxValue)
        case .unknown:
            return nil
        }
    }

    static func info(for jxValue: JXValue, in elementType: ElementType) throws -> ElementInfo {
        return try info(for: jxValue, in: elementType.rawValue)
    }
    
    static func info(for jxValue: JXValue, in elementName: String) throws -> ElementInfo {
        guard !jxValue.isUndefined else {
            throw JXSwiftUIErrors.undefinedValue(elementName)
        }
        guard let elementInfo = try self.for(jxValue) else {
            throw JXSwiftUIErrors.unknownValue(elementName, try jxValue.string)
        }
        return elementInfo
    }

    static func infoArray(for jxValue: JXValue, in elementType: ElementType) throws -> [ElementInfo] {
        return try infoArray(for: jxValue, in: elementType.rawValue)
    }
    
    static func infoArray(for jxValue: JXValue, in elementName: String) throws -> [ElementInfo] {
        guard !jxValue.isUndefined else {
            throw JXSwiftUIErrors.undefinedValue(elementName)
        }
        guard jxValue.isArray else {
            throw JXSwiftUIErrors.valueNotArray(elementName, try jxValue.string)
        }
        let contentArray = try jxValue.array
        return try (0 ..< contentArray.count).map { i in
            return try info(for: contentArray[i], in: elementName)
        }
    }
}
