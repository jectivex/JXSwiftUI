import JXKit

/// Used internally to handle errors within non-throwing SwiftUI code.
struct ErrorHandler {
    let handler: (Error) -> Void
    let elementPath: [String]
    
    func handle(_ error: Error) {
        // Use the element path to show where the error was detected
        var error = JXError(cause: error)
        if !elementPath.isEmpty {
            error.message = "\(error.message) @\(elementPath.joined(separator: "/"))"
        }
        handler(error)
    }
    
    /// Create a handler with an empty element path.
    var reset: ErrorHandler {
        return ErrorHandler(handler: handler, elementPath: [])
    }
    
    /// Create a handler traversing into the given element.
    func `in`(_ type: ElementType) -> ErrorHandler {
        return self.in(type.rawValue)
    }
    
    /// Create a handler traversing into the given element.
    func `in`(_ element: String) -> ErrorHandler {
        return ErrorHandler(handler: handler, elementPath: elementPath + [element])
    }
    
    /// Create a handler traversing into an attribute of the last traversed element.
    func attr(_ attribute: String) -> ErrorHandler {
        guard let last = elementPath.last else {
            return self
        }
        return ErrorHandler(handler: handler, elementPath: elementPath.dropLast() + [last + ".\(attribute)"])
    }
}
