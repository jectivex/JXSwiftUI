import JXBridge
import JXKit
import SwiftUI

/// Protocol with default implementations for modifiers that have no arguments.
protocol EmptyModifier: Element {
    static var type: ElementType { get }
    var target: Content { get }
    init(target: Content)
    func apply(to view: any View, errorHandler: ErrorHandler) -> any View
}

extension EmptyModifier {
    init(jxValue: JXValue) throws {
        let target = try Content(jxValue: jxValue["target"])
        self.init(target: target)
    }

    func view(errorHandler: ErrorHandler) -> any View {
        return apply(to: target.element(errorHandler: errorHandler)
            .view(errorHandler: errorHandler), errorHandler: errorHandler)
    }

    static func modifierJS(namespace: JXNamespace) -> String? {
        return """
function() {
    const e = new \(JSCodeGenerator.elementClass)('\(type.rawValue)');
    e.target = this;
    return e;
}
"""
    }
}
