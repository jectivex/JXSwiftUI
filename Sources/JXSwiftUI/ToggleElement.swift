import JXBridge
import JXKit
import SwiftUI

extension JXSwiftUISupport {
    /// A `SwiftUI.Toggle`.
    ///
    /// Supported usage:
    ///
    ///     - Toggle($on, 'label')
    ///     - Toggle($on, content)
    ///
    /// Supported `on`:
    ///
    ///     - `Binding` to a Bool
    ///
    /// Supported `content`:
    ///
    ///     - Label string
    ///     - View
    ///     - Anonymous function returning a View
    public enum Toggle {}
}

struct ToggleElement: Element {
    private let on: Binding<Bool>
    private let label: Content

    init(jxValue: JXValue) throws {
        self.on = try jxValue["on"].convey()
        self.label = try Content(jxValue: jxValue["content"])
    }

    func view(errorHandler: ErrorHandler) -> any View {
        let errorHandler = errorHandler.in(.toggle)
        return Toggle(isOn: on) {
            label.element(errorHandler: errorHandler)
                .view(errorHandler: errorHandler)
                .eraseToAnyView()
        }
    }

    static func js(namespace: JXNamespace) -> String? {
"""
function(on, content) {
    const e = new \(JSCodeGenerator.elementClass)('\(ElementType.toggle.rawValue)');
    e.on = on;
    e.content = content;
    return e;
}
"""
    }
}
