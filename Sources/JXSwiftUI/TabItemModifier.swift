import JXBridge
import JXKit
import SwiftUI

extension JXSwiftUISupport {
    /// Sets the tab item for a target view.
    ///
    /// Supported calls:
    ///
    ///     - .tabItem(content)
    ///
    /// Supported `content`:
    ///
    ///     - Label string
    ///     - View
    ///     - Anonymous function returning a View
    public enum tabItem {}
}

struct TabItemModifier: SingleValueModifier {
    static let type = ElementType.tabItemModifier
    let target: Content
    let value: Content

    static func convert(_ value: JXValue) throws -> Content {
        return try Content(jxValue: value)
    }

    func apply(to view: any View, errorHandler: ErrorHandler) -> any View {
        return view.tabItem {
            let tabItemErrorHandler = errorHandler.in(.tabItemModifier)
            value.element(errorHandler: tabItemErrorHandler)
                .view(errorHandler: tabItemErrorHandler)
                .eraseToAnyView()
        }
    }
}
