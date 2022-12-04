import JXBridge
import JXKit
import SwiftUI

/// Vends a `SwiftUI.Slider`.
struct SliderElement: Element {
    private let binding: Binding<Double>

    init(jxValue: JXValue) throws {
        self.binding = try jxValue["binding"].convey()
    }

    var elementType: ElementType {
        return .slider
    }
    
    func view(errorHandler: ErrorHandler?) -> any View {
        return Slider(value: binding, in: 0.0...1.0)
    }
    
    static func js(namespace: JXNamespace) -> String? {
"""
function(binding) {
    const e = new \(namespace.value).JXElement('\(ElementType.slider.rawValue)');
    e.binding = binding;
    return e;
}
"""
    }
}

