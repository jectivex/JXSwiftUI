import JXBridge
import JXKit
import SwiftUI

extension JXSwiftUISupport {
    /// Sets a line limit on a target view.
    ///
    /// Supported calls:
    ///
    ///     - .lineLimit(null)
    ///     - .lineLimit(number)
    public enum lineLimit {}
}

struct LineLimitModifier: SingleValueModifier {
    static let type = ElementType.lineLimitModifier
    let target: Content
    let value: Int?

    static func convert(_ value: JXValue) throws -> Int? {
        return try value.isNullOrUndefined ? nil : value.int
    }

    func apply(to view: any View, errorHandler: ErrorHandler) -> any View {
        return view.lineLimit(value)
    }
}
