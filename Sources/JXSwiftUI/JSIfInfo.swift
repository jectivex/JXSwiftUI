//
//  JSIfInfo.swift
//
//  Created by Abe White on 9/26/22.
//

import JXKit
import ScriptUI

struct JSIfInfo: IfInfo {
    private let _ifFunction: JXValue
    private let _elseFunction: JXValue

    init(jxValue: JXValue) throws {
        self.isTrue = try jxValue["isTrue"].booleanValue
        _ifFunction = try jxValue["ifFunction"]
        _elseFunction = try jxValue["elseFunction"]
    }

    var elementType: ScriptElementType {
        return .if
    }

    let isTrue: Bool

    var ifContentInfo: ScriptElementInfo {
        get throws {
            guard _ifFunction.isFunction else {
                // TODO: Throw informative error
                return EmptyElementInfo()
            }
            let ifContent = try _ifFunction.call(withArguments: [])
            return try JXElementInfo.content(for: ifContent, in: "If")
        }
    }

    var elseContentInfo: ScriptElementInfo? {
        get throws {
            guard !_elseFunction.isUndefined else {
                return nil
            }
            guard _elseFunction.isFunction else {
                // TODO: Throw informative error
                return EmptyElementInfo()
            }
            let elseContent = try _elseFunction.call(withArguments: [])
            return try JXElementInfo.content(for: elseContent, in: "If.else")
        }
    }
}
