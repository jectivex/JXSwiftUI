import JXKit
import SwiftUI

/// Wraps a `JXValue` that represents content. Content can be a string, element, custom view, or a function that returns an element or custom view.
struct Content {
    let jxValue: JXValue?
    let element: Element?
    
    static func `optional`(jxValue: JXValue) throws -> Content? {
        guard !jxValue.isNullOrUndefined else {
            return nil
        }
        return try Content(jxValue: jxValue)
    }
    
    init() {
        self.jxValue = nil
        self.element = nil
    }
    
    init(jxValue: JXValue) throws {
        if jxValue.isString {
            self.jxValue = nil
            self.element = try TextElement(text: jxValue.string)
        } else {
            self.jxValue = jxValue
            self.element = nil
        }
    }
    
    init(element: Element) {
        self.jxValue = nil
        self.element = element
    }
    
    init(view: any View) {
        self.jxValue = nil
        self.element = NativeElement(view: view)
    }
    
    func element(errorHandler: ErrorHandler) -> Element {
        if let element {
            return element
        }
        do {
            guard let jxValue, !jxValue.isNullOrUndefined else {
                throw JXError.missingContent()
            }
            return try extractElement(for: jxValue, errorHandler: errorHandler) ?? EmptyElement()
        } catch {
            errorHandler.handle(error)
            return EmptyElement()
        }
    }
    
    func elementArray(errorHandler: ErrorHandler) -> [Element] {
        do {
            if element != nil {
                throw JXError.contentNotArray()
            }
            guard let jxValue, !jxValue.isNullOrUndefined else {
                throw JXError.missingContent()
            }
            return try extractElementArray(for: jxValue, errorHandler: errorHandler)
        } catch {
            errorHandler.handle(error)
            return []
        }
    }
    
    private func extractElementArray(for jxValue: JXValue, errorHandler: ErrorHandler) throws -> [Element] {
        var arrayValue = jxValue
        if jxValue.isFunction {
            arrayValue = try jxValue.call()
        }
        guard arrayValue.isArray else {
            throw JXError(message: "Given JXSwiftUI content must be a JavaScript array or a function that returns an array")
        }
        return try arrayValue.array.enumerated().compactMap {
            let errorHandler = errorHandler.in("\($0.offset)")
            guard !jxValue.isNullOrUndefined else {
                let error = JXError(message: "Element of the JXSwiftUI content array has a null or undefined value")
                errorHandler.handle(error)
                return nil
            }
            return try extractElement(for: $0.element, errorHandler: errorHandler)
        }
    }
    
    private func extractElement(for jxValue: JXValue, errorHandler: ErrorHandler) throws -> Element? {
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
            errorHandler.in(elementType).handle(error)
            return nil
        }
    }
}
