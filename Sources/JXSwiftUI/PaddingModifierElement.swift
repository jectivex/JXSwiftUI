import JXBridge
import JXKit
import SwiftUI

/// Sets padding on its target view.
struct PaddingModifierElement: Element {
    private let target: Content
    
    init(jxValue: JXValue) throws {
        self.target = try Content(jxValue: jxValue["target"])
    }
    
    func view(errorHandler: ErrorHandler?) -> any View {
        return target.element(errorHandler: errorHandler)
            .view(errorHandler: errorHandler)
            .padding()
    }
    
    static func js(namespace: JXNamespace) -> String? {
        """
function(target) {
    const e = new \(namespace).JXElement('\(ElementType.paddingModifier.rawValue)');
    e.target = target;
    return e;
}
"""
    }
    
    static func modifierJS(for modifier: String, namespace: JXNamespace) -> String? {
        guard modifier == "padding" else {
            return nil
        }
        return """
function() {
    return \(namespace).\(ElementType.paddingModifier.rawValue)(this);
}
"""
    }
}
