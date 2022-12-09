import JXBridge
import JXKit
import SwiftUI

/// Sets padding on its target view.
struct PaddingModifier: Element {
    private let target: Content
    
    init(jxValue: JXValue) throws {
        self.target = try Content(jxValue: jxValue["target"])
    }
    
    func view(errorHandler: ErrorHandler?) -> any View {
        return target.element(errorHandler: errorHandler)
            .view(errorHandler: errorHandler)
            .padding()
    }
    
    static func modifierJS(namespace: JXNamespace) -> String? {
        return """
function() {
    const e = new \(JXNamespace.default).\(JSCodeGenerator.elementClass)('\(ElementType.paddingModifier.rawValue)');
    e.target = this;
    return e;
}
"""
    }
}
