import JXBridge
import JXKit
import SwiftUI

extension JXSwiftUISupport {
    /// A `SwiftUI.SecureField`.
    ///
    /// Supported usage:
    ///
    ///     - SecureField($text, 'label')
    ///     - SecureField($text, {props})
    ///     - SecureField($text, {props}, content)
    ///
    /// Supported `text`:
    ///
    ///     - `Binding` to a String
    ///
    /// Supported `props`:
    ///
    ///     - label: Content
    ///     - prompt: String
    ///
    /// Supported `content`:
    ///
    ///     - Label string
    ///     - View
    ///     - Anonymous function returning a View
    public enum SecureField {}
}

struct SecureFieldElement: Element {
    private let text: Binding<String>
    private let label: Content
    private let prompt: String?

    init(jxValue: JXValue) throws {
        self.text = try jxValue["text"].convey()
        let propsValue = try jxValue["props"]
        if propsValue.isString {
            self.label = try Content(jxValue: propsValue)
            self.prompt = nil
        } else {
            let promptValue = try propsValue["prompt"]
            self.prompt = try promptValue.isNullOrUndefined ? nil : promptValue.string

            let contentValue = try jxValue["content"]
            if contentValue.isUndefined {
                self.label = try Content(jxValue: propsValue["label"])
            } else {
                self.label = try Content(jxValue: contentValue)
            }
        }
    }

    func view(errorHandler: ErrorHandler) -> any View {
        let errorHandler = errorHandler.in(.secureField)
        let promptText = prompt == nil ? nil : Text(prompt!)
        return SecureField(text: text, prompt: promptText) {
            label.element(errorHandler: errorHandler)
                .view(errorHandler: errorHandler)
                .eraseToAnyView()
        }
    }

    static func js(namespace: JXNamespace) -> String? {
"""
function(text, props, content) {
    const e = new \(JSCodeGenerator.elementClass)('\(ElementType.textField.rawValue)');
    e.text = text;
    e.props = props;
    e.content = content;
    return e;
}
"""
    }
}
