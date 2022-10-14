//
//  JSSpacerInfo.swift
//
//  Created by Abe White on 9/28/22.
//

import JXKit
import ScriptUI

struct JSSpacerInfo: SpacerInfo {
    init(jxValue: JXValue) throws {
    }

    var elementType: ScriptElementType {
        return .spacer
    }
}
