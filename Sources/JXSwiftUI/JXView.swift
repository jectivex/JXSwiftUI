import JXBridge
import JXKit
import SwiftUI

/// A SwiftUI view that displays content defined in JavaScript.
public struct JXView: View {
    public let context: JXContext
    public let errorHandler: ((Error) -> Void)?
    public let bodyJX: (JXContext) throws -> JXValue

    /// Construct a view whose content is defined in JavaScript.
    ///
    /// - Parameters:
    ///   - context: An existing context. The ``JXSwiftUI`` module must be registered with the context. If not supplied, we create a new context for this view.
    ///   - errorHandler: An optional handler for JS errors. If not supplied, we print the error to the console.
    ///   - body: A closure returning a `JXValue` reprenting the content view. Typically you will use the supplied context to `eval` JS that returns a SwiftUI-in-JS view.
    public init(context: JXContext? = nil, errorHandler: ((Error) -> Void)? = { print("JXSwiftUI error: \($0)") }, body: @escaping (JXContext) throws -> JXValue) {
        self.context = context ?? JXContext()
        self.errorHandler = errorHandler
        self.bodyJX = body
        do {
            if context == nil {
                try self.context.registry.register(JXSwiftUI())
            }
        } catch {
            errorHandler?(error)
        }
    }

    public var body: some View {
        TypeSwitchView(info: bodyInfo, errorHandler: errorHandler)
    }

    private var bodyInfo: ElementInfo {
        do {
            let value = try bodyJX(context)
            return try JXElementInfo.info(for: value, in: "JXView")
        } catch {
            errorHandler?(error)
            return EmptyInfo()
        }
    }
}
