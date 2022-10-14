//
//  JSVStackInfo.swift
//
//  Created by Abe White on 9/26/22.
//

import JXKit
import ScriptUI

struct JSVStackInfo: VStackInfo {
    init(jxValue: JXValue) throws {
        self.contentInfo = try JXElementInfo.contentArray(for: jxValue, in: "VStack")
    }

    var elementType: ScriptElementType {
        return .vstack
    }

    let contentInfo: [ScriptElementInfo]
}
