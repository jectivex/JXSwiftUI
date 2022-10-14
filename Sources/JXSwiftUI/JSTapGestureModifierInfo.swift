//
//  JSTapGestureModifierInfo.swift
//
//  Created by Abe White on 9/26/22.
//

import JXKit
import ScriptUI

struct JSTapGestureModifierInfo: TapGestureModifierInfo {
    private let _onTapFunction: JXValue

    init(jxValue: JXValue) throws {
        self.targetInfo = try JXElementInfo.content(for: jxValue["target"], in: "onTapGesture")
        _onTapFunction = try jxValue["action"]
    }

    var elementType: ScriptElementType {
        return .tapGestureModifier
    }

    let targetInfo: ScriptElementInfo

    func onTapGesture() throws {
        try _onTapFunction.call(withArguments: [])
    }
}
