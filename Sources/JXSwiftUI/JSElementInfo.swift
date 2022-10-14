//
//  JXElementInfo.swift
//
//  Created by Abe White on 9/23/22.
//

import JXKit
import ScriptUI

// TODO: Fix error handling throughout this framework to throw

struct JXElementInfo: ScriptElementInfo {
    let elementType: ScriptElementType

    static func `for`(_ jxValue: JXValue) throws -> ScriptElementInfo? {
        let elementTypeString = try jxValue[CodeGenerator.elementTypeProperty].stringValue
        let elementType = ScriptElementType(rawValue: elementTypeString) ?? .unknown
        switch elementType {
        case .button:
            return try JSButtonInfo(jxValue: jxValue)
        case .custom:
            return try JSCustomInfo(jxValue: jxValue)
        case .empty:
            return EmptyElementInfo()
        case .foreach:
            return try JSForEachInfo(jxValue: jxValue)
        case .hstack:
            return try JSHStackInfo(jxValue: jxValue)
        case .if:
            return try JSIfInfo(jxValue: jxValue)
        case .list:
            return try JSListInfo(jxValue: jxValue)
        case .spacer:
            return try JSSpacerInfo(jxValue: jxValue)
        case .text:
            return try JSTextInfo(jxValue: jxValue)
        case .vstack:
            return try JSVStackInfo(jxValue: jxValue)

        case .fontModifier:
            return try JSFontModifierInfo(jxValue: jxValue)
        case .tapGestureModifier:
            return try JSTapGestureModifierInfo(jxValue: jxValue)
        case .unknown:
            return nil
        }
    }

    static func content(for jxValue: JXValue, in elementName: String) throws -> ScriptElementInfo {
        guard !jxValue.isUndefined else {
            // TODO: Throw informative error
            return EmptyElementInfo()
        }
        guard let elementInfo = try self.for(jxValue) else {
            // TODO: Throw informative error
            return EmptyElementInfo()
        }
        return elementInfo
    }

    static func contentArray(for jxValue: JXValue, in elementName: String) throws -> [ScriptElementInfo] {
        let contentValue = try jxValue["content"]
        guard !contentValue.isUndefined else {
            // TODO: Throw informative error
            return []
        }
        guard try contentValue.isArray else {
            // TODO: Throw informative error
            return []
        }
        let contentArray = try contentValue.array
        return try (0 ..< contentArray.count).map { i in
            return try self.content(for: contentArray[i], in: elementName)
        }
    }
}
