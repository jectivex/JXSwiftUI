import JXBridge
import JXKit
import SwiftUI

extension JXSwiftUISupport {
    /// A `SwiftUI.Picker`.
    ///
    /// Supported usage:
    ///
    ///     - Picker($selection, label, content)
    ///
    /// Supported `selection`:
    ///
    ///     - `Binding` to a Bool, Date, Double, or String
    ///
    /// Supported `label`:
    ///
    ///     - Label string
    ///     - View
    ///     - Anonymous function returning a View
    ///
    /// Supported `content`. If you do not use a `ForEach` with an `id` function of the selection type to list content, each content view must have a `tag` to give it a unique value:
    ///
    ///     - View array
    ///     - Anonymous function returning a View array
    public enum Picker {}
}

struct PickerElement: Element {
    private let selection: HashableBinding
    private let label: Content
    private let content: Content

    init(jxValue: JXValue) throws {
        self.selection = try jxValue["selection"].convey()
        self.label = try Content(jxValue: jxValue["label"])
        self.content = try Content(jxValue: jxValue["content"])
    }

    func view(errorHandler: ErrorHandler) -> any View {
        let errorHandler = errorHandler.in(.picker)
        let contentView = content.elementArray(errorHandler: errorHandler)
            .containerView(errorHandler: errorHandler)
        let labelErrorHandler = errorHandler.attr("label")
        let labelView = label.element(errorHandler: labelErrorHandler)
            .view(errorHandler: labelErrorHandler)
            .eraseToAnyView()
        switch selection {
        case .bool(let binding):
            return Picker(selection: binding) { contentView } label: { labelView }
        case .date(let binding):
            return Picker(selection: binding) { contentView } label: { labelView }
        case .double(let binding):
            return Picker(selection: binding) { contentView } label: { labelView }
        case .string(let binding):
            return Picker(selection: binding) { contentView } label: { labelView }
        }
    }

    static func js(namespace: JXNamespace) -> String? {
"""
function(selection, label, content) {
    const e = new \(JSCodeGenerator.elementClass)('\(ElementType.picker.rawValue)');
    e.selection = selection;
    e.label = label;
    e.content = content;
    return e;
}
"""
    }
}
