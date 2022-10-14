//
//  JSListInfo.swift
//
//  Created by Abe White on 9/28/22.
//

import JXKit
import ScriptUI

struct JSListInfo: ListInfo {
    init(jxValue: JXValue) throws {
        self.contentInfo = try JXElementInfo.contentArray(for: jxValue, in: "List")
    }

    var elementType: ScriptElementType {
        return .list
    }

    let contentInfo: [ScriptElementInfo]
}
