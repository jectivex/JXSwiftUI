import JXKit
import SwiftUI

extension JXSwiftUISupport {
    /// Sets a badge on a target view.
    ///
    /// Supported calls:
    ///
    ///     - .badge(string)
    ///     - .badge(number)
    ///     - .badge(Text)
    public enum badge {}
}

struct BadgeModifier: SingleValueModifier {
    static let type = ElementType.badgeModifier
    let target: Content
    let value: BadgeContent

    static func convert(_ value: JXValue) throws -> BadgeContent {
        if value.isNullOrUndefined {
            return .string(nil)
        } else if value.isNumber {
            return try .int(value.int)
        } else if value.isString {
            return try .string(value.string)
        } else {
            return try .content(Content(jxValue: value))
        }
    }

    func apply(to view: any View, errorHandler: ErrorHandler) -> any View {
        switch value {
        case .int(let value):
            return view.badge(value)
        case .string(let value):
            return view.badge(value)
        case .content(let value):
            let badgeErrorHandler = errorHandler.in(.badgeModifier)
            guard let badgeView = value.element(errorHandler: badgeErrorHandler)
                .view(errorHandler: badgeErrorHandler) as? Text else {
                badgeErrorHandler.handle(JXError(message: "Expected int, string, or Text content"))
                return view
            }
            return view.badge(badgeView)
        }
    }

    enum BadgeContent {
        case int(Int)
        case string(String?)
        case content(Content)
    }
}
