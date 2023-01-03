import JXBridge
import JXKit
import SwiftUI

extension JXSwiftUISupport {
    /// Tags the target view.
    ///
    /// Supported calls:
    ///
    ///     - .tag(value)
    ///
    /// The `value` should be a bool, number, string, or date.
    ///
    /// - Seealso: `Picker`
    public enum tag {}
}

struct TagModifier: Element {
    private let target: Content
    private let value: HashableValue

    init(jxValue: JXValue) throws {
        self.target = try Content(jxValue: jxValue["target"])
        self.value = try jxValue["value"].convey()
    }

    func view(errorHandler: ErrorHandler) -> any View {
        let targetView = target.element(errorHandler: errorHandler)
            .view(errorHandler: errorHandler)
        switch value {
        case .bool(let value):
            return targetView.tag(value)
        case .date(let value):
            return targetView.tag(value)
        case .double(let value):
            return targetView.tag(value)
        case .string(let value):
            return targetView.tag(value)
        }
    }

    static func modifierJS(namespace: JXNamespace) -> String? {
        return """
function(value) {
    const e = new \(JSCodeGenerator.elementClass)('\(ElementType.tagModifier.rawValue)');
    e.target = this;
    e.value = value;
    return e;
}
"""
    }
}
