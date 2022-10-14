//
//  JSTextInfo.swift
//
//  Created by Abe White on 9/26/22.
//

import JXKit
import ScriptUI

struct JSTextInfo: TextInfo {
    init(jxValue: JXValue) throws {
        self.text = try jxValue["text"].stringValue
    }

    init(text: String) {
        self.text = text
    }

    var elementType: ScriptElementType {
        return .text
    }

    let text: String
}
