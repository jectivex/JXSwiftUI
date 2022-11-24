/// Error types.
public enum JXSwiftUIErrors: Error {
    /// Attempt to put too many views into a container. Up to 10 views are supported. Use `Group` to group views.
    case tooManyViews
    
    /// Encountered an undefined value when evaluating JavaScript.
    /// (Context)
    case undefinedValue(String)
    
    /// Encountered an unknown value when evaluating JavaScript.
    /// (Context, value)
    case unknownValue(String, String)
    
    /// Expected a JavaScript array.
    /// (Context, value)
    case valueNotArray(String, String)
    
    /// Expected a JavaScript function.
    /// (Context, value)
    case valueNotFunction(String, String)
}
