import JXBridge
import JXKit
import SwiftUI

extension JXSwiftUISupport {
    /// A `SwiftUI.NavigationLink`.
    ///
    /// Supported usage:
    ///
    ///     - NavigationLink('label', () => { destination })
    ///     - NavigationLink(() => { destination }, content)
    ///
    /// Supported `destination`:
    ///
    ///     - Anonymous function returning a View
    ///
    /// Supported `content`:
    ///
    ///     - View
    ///     - Anonymous function returning a View
    public enum NavigationLink {}
}

// TODO: Build in support for lazy detinations? Currently runs destination immediately

struct NavigationLinkElement: Element {
    private let content: Content
    private let destination: Content

    init(jxValue: JXValue) throws {
        let args = try jxValue["args"].array
        guard args.count >= 2 else {
            throw JXError(message: "A destination function and a label or content are required")
        }
        if args[0].isString {
            self.content = try Content(jxValue: args[0])
            self.destination = try Content(jxValue: args[1])
        } else {
            self.content = try Content(jxValue: args[1])
            self.destination = try Content(jxValue: args[0])
        }
    }

    func view(errorHandler: ErrorHandler) -> any View {
        let errorHandler = errorHandler.in(.navigationLink)
        return NavigationLink(destination: {
            let errorHandler = errorHandler.attr("destination")
            return destination.element(errorHandler: errorHandler)
                .view(errorHandler: errorHandler)
                .eraseToAnyView()
        }) {
            content.element(errorHandler: errorHandler)
                .view(errorHandler: errorHandler)
                .eraseToAnyView()
        }
    }
    
    static func js(namespace: JXNamespace) -> String? {
        """
function(...args) {
    const e = new \(JSCodeGenerator.elementClass)('\(ElementType.navigationLink.rawValue)');
    e.args = args;
    return e;
}
"""
    }
}

