//
//  JSFontModifierInfo.swift
//
//  Created by Abe White on 9/28/22.
//

import JXKit
import ScriptUI
import SwiftUI

struct JSFontModifierInfo: FontModifierInfo {
    init(jxValue: JXValue) throws {
        self.targetInfo = try JXElementInfo.content(for: jxValue["target"], in: "font")
        let fontName = try jxValue["fontName"].stringValue
        self.font = Self._font(for: fontName)
    }

    var elementType: ScriptElementType {
        return .fontModifier
    }

    let targetInfo: ScriptElementInfo

    let font: Font

    private static func _font(for fontString: String) -> Font {
        // TODO: Flesh out font support
        switch fontString {
        case "title":
            return .title
        case "body":
            return .body
        case "caption":
            return .caption
        default:
            return .body
        }
    }
}
