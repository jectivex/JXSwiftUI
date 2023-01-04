import JXBridge
import JXKit
import SwiftUI

extension JXSwiftUISupport {
    /// A `SwiftUI.TabView`.
    ///
    /// Supported usage:
    ///
    ///     - TabView($selection, content)
    ///
    /// Supported `selection`:
    ///
    ///     - `Binding` to a Bool, Date, Double, or String
    ///
    /// Supported `content`. Use the `tabItem` modifier to configure the tab for each item:
    ///
    ///     - View array
    ///     - Anonymous function returning a View array
    public enum TabView {}
}

struct TabViewElement: Element {
    private let selection: HashableBinding
    private let content: Content

    init(jxValue: JXValue) throws {
        self.selection = try jxValue["selection"].convey()
        self.content = try Content(jxValue: jxValue["content"])
    }

    func view(errorHandler: ErrorHandler) -> any View {
        let errorHandler = errorHandler.in(.tabView)
        let contentView = content.elementArray(errorHandler: errorHandler)
            .containerView(errorHandler: errorHandler)
        switch selection {
        case .bool(let binding):
            return TabView(selection: binding) { contentView }
        case .date(let binding):
            return TabView(selection: binding) { contentView }
        case .double(let binding):
            return TabView(selection: binding) { contentView }
        case .string(let binding):
            return TabView(selection: binding) { contentView }
        }
    }

    static func js(namespace: JXNamespace) -> String? {
"""
function(selection, content) {
    const e = new \(JSCodeGenerator.elementClass)('\(ElementType.tabView.rawValue)');
    e.selection = selection;
    e.content = content;
    return e;
}
"""
    }
}
