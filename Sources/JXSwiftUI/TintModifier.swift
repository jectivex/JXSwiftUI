import JXBridge
import JXKit
import SwiftUI

extension JXSwiftUISupport {
    /// Sets a tint color on a target view.
    ///
    /// Supported calls:
    ///
    ///     - .tint('name')
    ///     - .tint(Color)
    public enum tint {}
}

struct TintModifier: SingleValueModifier {
    static let type = ElementType.tintModifier
    let target: Content
    let value: Color

    static func convert(_ value: JXValue) throws -> Color {
        return try value.isString ? Color(value.string) : value.convey()
    }

    func apply(to view: any View, errorHandler: ErrorHandler) -> any View {
        return view.tint(value)
    }
}
