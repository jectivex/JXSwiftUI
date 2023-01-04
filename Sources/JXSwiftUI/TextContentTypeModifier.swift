import JXBridge
import JXKit
import SwiftUI

extension JXSwiftUISupport {
    /// Sets the text content type on a target view.
    ///
    /// Supported calls:
    ///
    ///     - .textContentType(UITextContentType)
    public enum textContentType {}

#if os(macOS)
    /// Use a JavaScript string to name any standard `AppKit.NSTextContentType` value, e.g. `'emailAddress'`.
    public enum NSTextContentType {}
#else
    /// Use a JavaScript string to name any standard `UIKit.UITextContentType` value, e.g. `'emailAddress'`.
    public enum UITextContentType {}
#endif
}

struct TextContentTypeModifier: SingleValueModifier {
    static let type = ElementType.textContentTypeModifier
    let target: Content
#if os(macOS)
    let value: NSTextContentType

    static func convert(_ value: JXValue) throws -> NSTextContentType {
        return try value.convey()
    }
#else
    let value: UITextContentType

    static func convert(_ value: JXValue) throws -> UITextContentType {
        return try value.convey()
    }
#endif

    func apply(to view: any View, errorHandler: ErrorHandler) -> any View {
        return view.textContentType(value)
    }
}
