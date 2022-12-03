import JXBridge
import JXKit
import SwiftUI

/// A SwiftUI view that displays content defined in JavaScript.
public struct JXView: View {
    public let context: JXContext
    public let errorHandler: ((Error) -> Void)?
    
    private let contentErrorHandler: ErrorHandler?
    private let contentElement: Element
    
    /// Construct a view whose content is defined in JavaScript.
    ///
    /// - Parameters:
    ///   - context: An existing context. The ``JXSwiftUI`` module must be registered with the context. If not supplied, we create a new context for this view.
    ///   - errorHandler: An optional handler for JS errors. If not supplied, we print the error to the console.
    ///   - content: A closure returning a `JXValue` reprenting the content view. Typically you will use the supplied context to `eval` JS that returns a SwiftUI-in-JS view.
    public init(context: JXContext? = nil, errorHandler: ((Error) -> Void)? = { print("\($0)") }, content: @escaping (JXContext) throws -> JXValue) {
        self.context = context ?? JXContext()
        self.errorHandler = errorHandler
        
        contentErrorHandler = errorHandler == nil ? nil : ErrorHandler(handler: errorHandler!, elementPath: [])
        do {
            if context == nil {
                try self.context.registry.register(JXSwiftUI())
            }
            let contentValue = try content(self.context)
            contentElement =  Content(jxValue: contentValue).element(errorHandler: contentErrorHandler)
        } catch {
            contentElement = EmptyElement()
            contentErrorHandler?.handle(error)
        }
    }

    public var body: some View {
        contentElement.view(errorHandler: contentErrorHandler)
            .eraseToAnyView()
    }
}
