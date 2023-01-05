import JXBridge
import JXKit
import SwiftUI

extension JXSwiftUISupport {
    /// Sets a foreground color on a target view.
    /// 
    /// Supported calls:
    ///
    ///     - .foregroundColor('name')
    ///     - .foregroundColor(Color)
    public enum foregroundColor {}
}

struct ForegroundColorModifier: SingleValueModifier {
    static let type = ElementType.foregroundColorModifier
    let target: Content
    let value: Color

    static func convert(_ value: JXValue) throws -> Color {
        return try value.isString ? Color(value.string) : value.convey()
    }

    func apply(to view: any View, errorHandler: ErrorHandler) -> any View {
        // Keep Text chaining alive
        if let text = view as? Text {
            return text.foregroundColor(value)
        } else {
            return view.foregroundColor(value)
        }
    }
}
