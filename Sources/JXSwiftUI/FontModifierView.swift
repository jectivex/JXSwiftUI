import JXKit
import SwiftUI

/// A view that specifies a font for its target view.
struct FontModifierView: View {
    let info: FontModifierInfo
    let errorHandler: ErrorHandler?

    var body: some View {
        info.targetInfo.view(errorHandler: errorHandler)
            .font(info.font)
    }
}

struct FontModifierInfo: ElementInfo {
    init(jxValue: JXValue) throws {
        self.targetInfo = try Self.info(for: jxValue["target"], in: .fontModifier)
        let fontName = try jxValue["fontName"].string
        self.font = try Self.font(for: fontName)
    }

    var elementType: ElementType {
        return .fontModifier
    }

    let targetInfo: ElementInfo

    let font: Font

    private static func font(for fontString: String) throws -> Font {
        switch fontString {
        case "title":
            return .title
        case "body":
            return .body
        case "caption":
            return .caption
        default:
            throw JXSwiftUIErrors.unknownValue(ElementType.fontModifier.rawValue, fontString)
        }
    }
}
