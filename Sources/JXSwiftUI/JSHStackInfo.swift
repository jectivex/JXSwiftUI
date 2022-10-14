//
//  JSHStackInfo.swift
//
//  Created by Abe White on 9/28/22.
//

import JXKit
import ScriptUI

struct JSHStackInfo: HStackInfo {
    init(jxValue: JXValue) throws {
        self.contentInfo = try JXElementInfo.contentArray(for: jxValue, in: "HStack")
    }

    var elementType: ScriptElementType {
        return .hstack
    }

    let contentInfo: [ScriptElementInfo]
}
