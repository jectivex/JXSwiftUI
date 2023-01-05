import JXBridge
import JXKit
import SwiftUI

extension JXSwiftUISupport {
    /// A `SwiftUI.TabView`.
    ///
    /// Supported usage:
    ///
    ///     - TabView(content)
    ///     - TabView($selection, content)
    ///
    /// Supported `selection`:
    ///
    ///     - `Binding` to a Bool, Date, Double, String, or any bridged `Hashable` object
    ///
    /// Supported `content`. Use the `tabItem` modifier to configure the tab for each item:
    ///
    ///     - View array
    ///     - Anonymous function returning a View array
    public enum TabView {}
}

struct TabViewElement: Element {
    private let selection: HashableBinding?
    private let content: Content

    init(jxValue: JXValue) throws {
        let selectionValue = try jxValue["selection"]
        if selectionValue.isNullOrUndefined {
            self.selection = nil
        } else {
            self.selection = try selectionValue.convey(to: HashableBinding.self)
        }
        self.content = try Content(jxValue: jxValue["content"])
    }

    func view(errorHandler: ErrorHandler) -> any View {
        let errorHandler = errorHandler.in(.tabView)
        let contentView = content.elementArray(errorHandler: errorHandler)
            .containerView(errorHandler: errorHandler)
        guard let selection else {
            return TabView { contentView }
        }
        switch selection {
        case .bool(let binding):
            return TabView(selection: binding) { contentView }
        case .date(let binding):
            return TabView(selection: binding) { contentView }
        case .double(let binding):
            return TabView(selection: binding) { contentView }
        case .string(let binding):
            return TabView(selection: binding) { contentView }
        case .hashable(let binding):
            return TabView(selection: binding) { contentView }
        }
    }

    static func js(namespace: JXNamespace) -> String? {
"""
function(selectionOrContent, content) {
    const e = new \(JSCodeGenerator.elementClass)('\(ElementType.tabView.rawValue)');
    if (content === undefined) {
        e.content = selectionOrContent;
    } else {
        e.selection = selectionOrContent;
        e.content = content;
    }
    return e;
}
"""
    }
}
