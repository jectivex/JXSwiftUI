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

struct TextContentTypeModifier: Element {
    private let target: Content
#if os(macOS)
    private let type: NSTextContentType
#else
    private let type: UITextContentType
#endif

    init(jxValue: JXValue) throws {
        self.target = try Content(jxValue: jxValue["target"])
        self.type = try jxValue["type"].convey()
    }

    func view(errorHandler: ErrorHandler) -> any View {
        return target.element(errorHandler: errorHandler)
            .view(errorHandler: errorHandler)
            .textContentType(type)
    }

    static func modifierJS(namespace: JXNamespace) -> String? {
        return """
function(type) {
    const e = new \(JSCodeGenerator.elementClass)('\(ElementType.textContentTypeModifier.rawValue)');
    e.target = this;
    e.type = type;
    return e;
}
"""
    }
}
