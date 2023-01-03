import JXBridge
import JXKit
import SwiftUI

extension JXSwiftUISupport {
    /// A `SwiftUI.TextEditor`.
    ///
    /// Supported usage:
    ///
    ///     - TextEditor($text)
    ///
    /// Supported `text`:
    ///
    ///     - `Binding` to a String
    public enum TextEditor {}
}

struct TextEditorElement: Element {
    private let text: Binding<String>

    init(jxValue: JXValue) throws {
        self.text = try jxValue["text"].convey()
    }

    func view(errorHandler: ErrorHandler) -> any View {
        return TextEditor(text: text)
    }

    static func js(namespace: JXNamespace) -> String? {
"""
function(text) {
    const e = new \(JSCodeGenerator.elementClass)('\(ElementType.textEditor.rawValue)');
    e.text = text;
    return e;
}
"""
    }
}

