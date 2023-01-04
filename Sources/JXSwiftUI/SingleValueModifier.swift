import JXBridge
import JXKit
import SwiftUI

/// Protocol with default implementations for modifiers that accept a single argument.
protocol SingleValueModifier: Element {
    associatedtype T

    static var type: ElementType { get }
    static func convert(_ value: JXValue) throws -> T

    var target: Content { get }
    var value: T { get }
    init(target: Content, value: T)
    func apply(to view: any View, errorHandler: ErrorHandler) -> any View
}

extension SingleValueModifier {
    init(jxValue: JXValue) throws {
        let target = try Content(jxValue: jxValue["target"])
        let value = try Self.convert(jxValue["value"])
        self.init(target: target, value: value)
    }

    func view(errorHandler: ErrorHandler) -> any View {
        return apply(to: target.element(errorHandler: errorHandler)
            .view(errorHandler: errorHandler), errorHandler: errorHandler)
    }

    static func modifierJS(namespace: JXNamespace) -> String? {
        return """
function(value) {
    const e = new \(JSCodeGenerator.elementClass)('\(type.rawValue)');
    e.target = this;
    e.value = value;
    return e;
}
"""
    }
}
