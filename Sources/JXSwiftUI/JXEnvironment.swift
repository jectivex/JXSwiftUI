import JXKit
import SwiftUI

/// `JXSwiftUI` contextual information passed through the environment. Any context and error handler passed to the ``JXView`` constructor override environmental values and establish new environment defaults for downstream views.
public struct JXEnvironment {
    public init(context: JXContext? = nil, errorHandler: ((Error) -> Void)? = nil) {
        let envContext = context ?? JXContext()
        self.context = envContext
        self.errorHandler = errorHandler ?? { envContext.configuration.log("\($0)") }
    }
    
    public let context: JXContext
    public let errorHandler: (Error) -> Void
}

/// Key for local `JXEnvironment`.
private struct JXEnvironmentKey: EnvironmentKey {
    static let defaultValue = JXEnvironment()
}

extension EnvironmentValues {
    /// Access the local ``JXEnvironment``.
    public var jx: JXEnvironment {
        get {
            return self[JXEnvironmentKey.self]
        }
        set {
            self[JXEnvironmentKey.self] = newValue
        }
    }
}

extension View {
    /// Supply JX environment values to ``JXView``.
    public func jxEnvironment(_ context: JXContext? = nil, errorHandler: ((Error) -> Void)? = nil) -> some View {
        return self.environment(\.jx, JXEnvironment(context: context, errorHandler: errorHandler))
    }
}
