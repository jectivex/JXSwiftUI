import JXKit
import SwiftUI

struct FontModifierInfo: ElementInfo {
    private let targetInfo: ElementInfo
    private let font: Font
    
    init(jxValue: JXValue) throws {
        self.targetInfo = try Self.info(for: jxValue["target"], in: .fontModifier)
        let fontName = try jxValue["fontName"].string
        self.font = try Self.font(for: fontName)
    }

    var elementType: ElementType {
        return .fontModifier
    }

    @ViewBuilder
    func view(errorHandler: ErrorHandler?) -> any View {
        targetInfo.view(errorHandler: errorHandler)
            .font(font)
    }

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
