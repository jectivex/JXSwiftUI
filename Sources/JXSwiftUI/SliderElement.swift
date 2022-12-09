import JXBridge
import JXKit
import SwiftUI

/// Vends a `SwiftUI.Slider`.
struct SliderElement: Element {
    private let binding: Binding<Double>

    init(jxValue: JXValue) throws {
        self.binding = try jxValue["binding"].convey()
    }

    func view(errorHandler: ErrorHandler?) -> any View {
        return Slider(value: binding, in: 0.0...1.0)
    }
    
    static func js(namespace: JXNamespace) -> String? {
"""
function(binding) {
    const e = new \(JXNamespace.default).\(JSCodeGenerator.elementClass)('\(ElementType.slider.rawValue)');
    e.binding = binding;
    return e;
}
"""
    }
}

