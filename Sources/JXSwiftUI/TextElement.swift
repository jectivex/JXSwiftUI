import JXBridge
import JXKit
import SwiftUI

/// Vends a `SwiftUI.Text`.
struct TextElement: Element {
    private let text: String
    
    init(jxValue: JXValue) throws {
        self.text = try jxValue["text"].string
    }

    init(text: String) {
        self.text = text
    }

    func view(errorHandler: ErrorHandler?) -> any View {
        return Text(text)
    }
    
    static func js(namespace: JXNamespace) -> String? {
        """
function(text) {
    const e = new \(namespace).JXElement('\(ElementType.text.rawValue)');
    e.text = text;
    return e;
}
"""
    }
}
