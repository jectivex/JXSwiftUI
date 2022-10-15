import JXKit
import SwiftUI

struct JXFontModifierInfo: FontModifierInfo {
    init(jxValue: JXValue) throws {
        self.targetInfo = try JXElementInfo.info(for: jxValue["target"], in: "font")
        let fontName = try jxValue["fontName"].string
        self.font = try Self.font(for: fontName)
    }

    var elementType: ElementType {
        return .fontModifier
    }

    let targetInfo: ElementInfo

    let font: Font

    private static func font(for fontString: String) throws -> Font {
        // TODO: Flesh out font support
        switch fontString {
        case "title":
            return .title
        case "body":
            return .body
        case "caption":
            return .caption
        default:
            // TODO: Throw error
            return .body
        }
    }
}
