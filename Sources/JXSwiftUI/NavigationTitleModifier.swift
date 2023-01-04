import JXBridge
import JXKit
import SwiftUI

extension JXSwiftUISupport {
    /// Sets a navigation title on a target view.
    /// 
    /// Supported calls:
    ///
    ///     - .navigationTitle('title')
    ///     - .navigationTitle(Text)
    public enum navigationTitle {}
}

struct NavigationTitleModifier: SingleValueModifier {
    static let type = ElementType.navigationTitleModifier
    let target: Content
    let value: Content

    static func convert(_ value: JXValue) throws -> Content {
        return try Content(jxValue: value)
    }

    func apply(to view: any View, errorHandler: ErrorHandler) -> any View {
        let titleErrorHandler = errorHandler.in(.navigationTitleModifier)
        guard let titleText = value.element(errorHandler: titleErrorHandler)
            .view(errorHandler: titleErrorHandler) as? Text else {
            titleErrorHandler.handle(JXError(message: "Expected a string or Text view"))
            return view
        }
        return view.navigationTitle(titleText)
    }
}
