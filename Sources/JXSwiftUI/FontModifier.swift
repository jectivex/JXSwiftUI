import JXKit
import SwiftUI

extension JXSwiftUISupport {
    /// Sets a font on a target view.
    /// 
    /// Supported calls:
    ///
    ///     - .font(FontTextStyle)
    ///     - .font(Font)
    public enum font {}
}

struct FontModifier: SingleValueModifier {
    static let type = ElementType.fontModifier
    let target: Content
    let value: Font

    static func convert(_ value: JXValue) throws -> Font {
        if value.isString {
            let style = try value.convey(to: Font.TextStyle.self)
            return Font.system(style)
        } else {
            return try value.convey()
        }
    }
    
    func apply(to view: any View, errorHandler: ErrorHandler) -> any View {
        // Keep Text chaining alive
        if let text = view as? Text {
            return text.font(value)
        } else {
            return view.font(value)
        }
    }
}
