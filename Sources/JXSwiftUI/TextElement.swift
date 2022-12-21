import JXBridge
import JXKit
import SwiftUI

extension JXSwiftUISupport {
    /// A `SwiftUI.Text`.
    ///
    /// Supported usage:
    ///
    ///     - Text('text/markdown')
    ///     - Text({props}, 'text/markdown')
    ///
    /// Supported `props`:
    ///
    ///     - verbatim: If true, the text will be included verbatim
    ///
    /// Supported additional functions:
    ///
    ///     - .fontWeight(FontWeight)
    ///     - .bold(boolean=true)
    ///     - .italic(boolean=true)
    ///     - .monospacedDigit(boolean=true)
    ///     - .strikethrough(boolean=true)
    ///     - .underline(boolean=true)
    public enum Text {}
}

// TODO: Test that .font() and .foregroundColor() can be used when the caller expects Text, e.g. on navigationTitle
// TODO: tint, lineLimit, allowsTightening, minimumScaleFactor modifiers

struct TextElement: Element {
    private let text: LocalizedStringKey?
    private let verbatim: String?
    private let decorations: [(Text) -> Text]
    
    
    init(jxValue: JXValue) throws {
        let textValue = try jxValue["text"]
        if textValue.isUndefined {
            self.text = nil
            self.verbatim = try jxValue["verbatim"].string
        } else {
            self.text = try LocalizedStringKey(textValue.string)
            self.verbatim = nil
        }
        var decorations: [(Text) -> Text] = []
        if !(try jxValue["fontWeightValue"].isUndefined) {
            let value = try jxValue["fontWeightValue"].convey(to: Font.Weight.self)
            decorations.append({ $0.fontWeight(value) })
        }
        try Self.append(to: &decorations, ifProperty: "boldValue", of: jxValue) { $0.bold() }
        try Self.append(to: &decorations, ifProperty: "italicValue", of: jxValue) { $0.italic() }
        try Self.append(to: &decorations, ifProperty: "monospacedDigitValue", of: jxValue) { $0.monospacedDigit() }
        try Self.append(to: &decorations, ifProperty: "strikethroughValue", of: jxValue) { $0.strikethrough() }
        try Self.append(to: &decorations, ifProperty: "underlineValue", of: jxValue) { $0.underline() }
        self.decorations = decorations
    }

    init(text: String) {
        self.text = LocalizedStringKey(text)
        self.verbatim = nil
        self.decorations = []
    }

    func view(errorHandler: ErrorHandler) -> any View {
        let errorHandler = errorHandler.in(.text)
        var text: Text
        if let verbatim {
            text = Text(verbatim: verbatim)
        } else if let key = self.text {
            text = Text(key)
        } else {
            errorHandler.handle(JXError.internalError("Missing text"))
            return EmptyView()
        }
        for decoration in decorations {
            text = decoration(text)
        }
        return text
    }
    
    static func js(namespace: JXNamespace) -> String? {
        """
function(propsOrText, text) {
    const e = new \(JSCodeGenerator.elementClass)('\(ElementType.text.rawValue)');
    if (text === undefined) {
        e.text = propsOrText;
    } else {
        if (propsOrText.verbatim == true) {
            e.verbatim = text;
        } else {
            e.text = text;
        }
    }
    e.fontWeight = function(value) {
        e.fontWeightValue = value;
        return e;
    }
    e.bold = function(value=true) {
        e.boldValue = value;
        return e;
    }
    e.italic = function(value=true) {
        e.italicValue = value;
        return e;
    }
    e.monospacedDigit = function(value=true) {
        e.monospacedDigitValue = value;
        return e;
    }
    e.strikethrough = function(value=true) {
        e.strikethroughValue = value;
        return e;
    }
    e.underline = function(value=true) {
        e.underlineValue = value;
        return e;
    }
    return e;
}
"""
    }
    
    private static func append(to decorations: inout [(Text) -> Text], ifProperty property: String, of jxValue: JXValue, decoration: @escaping (Text) -> Text) throws {
        let value = try jxValue[property]
        if !value.isUndefined && value.bool {
            decorations.append(decoration)
        }
    }
}
