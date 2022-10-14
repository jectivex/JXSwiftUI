//
//  JSButtonInfo.swift
//
//  Created by Abe White on 9/28/22.
//

import JXKit
import ScriptUI

struct JSButtonInfo: ButtonInfo {
    private let _actionFunction: JXValue

    init(jxValue: JXValue) throws {
        self.contentInfo = try JXElementInfo.content(for: jxValue["content"], in: "Button")
        _actionFunction = try jxValue["action"]
    }

    var elementType: ScriptElementType {
        return .button
    }

    let contentInfo: ScriptElementInfo

    func onAction() throws {
        try _actionFunction.call(withArguments: [])
    }
}
