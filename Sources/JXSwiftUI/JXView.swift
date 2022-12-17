import JXBridge
import JXKit
import SwiftUI

/// A SwiftUI view that displays content defined in JavaScript.
public struct JXView: View {
    @Environment(\.jx) private var jxEnvironment: JXEnvironment
    private let context: JXContext?
    private let errorHandler: ((Error) -> Void)?
    private let content: (JXContext) throws -> JXValue
    
    /// Construct a view whose content is defined in JavaScript.
    ///
    /// - Parameters:
    ///   - context: An existing context. If not supplied, we use the ``JXEnvironment`` value, which defaults to a new context.
    ///   - errorHandler: An optional handler for JavaScript errors. If not supplied, we use the ``JXEnvironment`` value, which defaults to printing errors to the console.
    ///   - content: A closure returning a `JXValue` reprenting the content view. Typically you will use the supplied context to `eval` JavaScript that returns a `JXSwiftUI` view.
    public init(context: JXContext? = nil, errorHandler: ((Error) -> Void)? = nil, content: @escaping (JXContext) throws -> JXValue) {
        self.context = context
        self.errorHandler = errorHandler
        self.content = content
    }
    
    public var body: some View {
        let jxErrorHandler = ErrorHandler(handler: self.errorHandler ?? jxEnvironment.errorHandler, elementPath: [])
        return contentElement(errorHandler: jxErrorHandler)
            .view(errorHandler: jxErrorHandler)
            .eraseToAnyView()
            .jxEnvironment(context ?? jxEnvironment.context, errorHandler: errorHandler ?? jxEnvironment.errorHandler)
    }
    
    private func contentElement(errorHandler: ErrorHandler) -> Element {
        let context = context ?? jxEnvironment.context
        do {
            if context.registry.module(for: .jxswiftui) == nil {
                try context.registry.register(JXSwiftUI())
            }
            let contentValue = try content(context)
            return try Content(jxValue: contentValue).element(errorHandler: errorHandler)
        } catch {
            errorHandler.handle(error)
            return EmptyElement()
        }
    }
}
