import JXKit

/// Wraps a `JXValue` that represents content. Content can be a JXSwiftUIElement, custom view, or a function that returns one of those.
struct Content {
    let jxValue: JXValue
    
    func element(errorHandler: ErrorHandler?) -> Element {
        do {
            guard !jxValue.isNullOrUndefined else {
                throw JXError(message: "JXSwiftUI content is missing or has a null value")
            }
            return try extractElement(for: jxValue, errorHandler: errorHandler) ?? EmptyElement()
        } catch {
            errorHandler?.handle(error)
            return EmptyElement()
        }
    }
    
    func elementArray(errorHandler: ErrorHandler?) -> [Element] {
        do {
            guard !jxValue.isNullOrUndefined else {
                throw JXError(message: "JXSwiftUI content is missing or has a null value")
            }
            return try extractElementArray(errorHandler: errorHandler)
        } catch {
            errorHandler?.handle(error)
            return []
        }
    }
    
    private func extractElementArray(errorHandler: ErrorHandler?) throws -> [Element] {
        var arrayValue = jxValue
        if jxValue.isFunction {
            arrayValue = try jxValue.call()
        }
        guard arrayValue.isArray else {
            throw JXError(message: "Given JXSwiftUI content must be a JavaScript array or a function that returns an array")
        }
        return try arrayValue.array.enumerated().compactMap {
            let errorHandler = errorHandler?.in("\($0.offset)")
            guard !jxValue.isNullOrUndefined else {
                let error = JXError(message: "Element of the JXSwiftUI content array has a null or undefined value")
                errorHandler?.handle(error)
                return nil
            }
            return try extractElement(for: $0.element, errorHandler: errorHandler)
        }
    }
    
    private func extractElement(for jxValue: JXValue, errorHandler: ErrorHandler?) throws -> Element? {
        var elementValue = jxValue
        if jxValue.isFunction {
            elementValue = try jxValue.call()
        }
        
        let elementType: ElementType
        if elementValue.hasProperty(JSCodeGenerator.elementTypeProperty) {
            let elementTypeString = try elementValue[JSCodeGenerator.elementTypeProperty].string
            guard let rawType = ElementType(rawValue: elementTypeString) else {
                throw JXError.internalError("Unrecognized JXSwiftUI element type '\(elementTypeString)'")
            }
            elementType = rawType
        } else {
            elementType = .native
        }

        do {
            guard let element = try elementType.valueType?.init(jxValue: elementValue) else {
                throw JXError.internalError("Unknown element type: \(elementType)")
            }
            return element
        } catch {
            // Handle constructor errors here where we know what we were trying to construct
            errorHandler?.in(elementType).handle(error)
            return nil
        }
    }
}
