import JXKit

extension JXError {
    static func contentNotArray() -> JXError {
        return JXError(message: "Given JXSwiftUI content must be a JavaScript array or a function that returns an array")
    }

    static func invalid(value: String, for type: Any.Type) -> JXError {
        return JXError(message: "'\(value)' is not a valid '\(type)' value")
    }
    
    static func missingContent() -> JXError {
        return JXError(message: "JXSwiftUI content is missing or has a null value. Did you forget to 'return' a value from a function?")
    }
}
