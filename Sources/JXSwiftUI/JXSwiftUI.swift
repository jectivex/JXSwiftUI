import Combine
import JXBridge
import JXKit
import SwiftUI

/// Register this module to use SwiftUI-in-JS in a context.
public struct JXSwiftUI: JXModule {
    public init() {
    }
    
    public let namespace: JXNamespace = "swiftui"
    
    public func initialize(in context: JXContext) throws {
        // Function custom elements trigger on state change, passing in their observer
        let willChangeFunction = JXValue(newFunctionIn: context) { context, this, args in
            guard args.count == 1 else {
                return context.undefined()
            }
            let observerValue = args[0]
            if let observer = observerValue.peer as? WillChangeObserver {
                observer.willChange()
            }
            return context.undefined()
        }
        try context.global[namespace].setProperty(JSCodeGenerator.willChangeFunction, willChangeFunction)
        
        // Call SwiftUI.withAnimation { ... }
        let withAnimationFunction = JXValue(newFunctionIn: context) { context, this, args in
            guard args.count == 1 else {
                return context.undefined()
            }
            let functionBlock = args[0]
            let result = try withAnimation {
                try functionBlock.call()
            }
            return try context.convey(result)
        }
        try context.global[namespace].setProperty(JSCodeGenerator.withAnimationFunction, withAnimationFunction)
        
        let initializeJS = JSCodeGenerator.initializationJS(namespace: namespace)
        try context.eval(initializeJS)
    }
    
    public func define(symbol: String, namespace: JXNamespace, in context: JXContext) throws -> Bool {
        guard let elementType = ElementType(rawValue: symbol), let js = JSCodeGenerator.elementJS(for: elementType, namespace: namespace) else {
            return false
        }
        try context.eval(js)
        return true
    }
    
    public func defineAll(namespace: JXNamespace, in context: JXContext) throws -> Bool {
        let namespaceValue = try context.global[namespace]
        for elementType in ElementType.allCases {
            guard !namespaceValue.hasProperty(elementType.rawValue) else {
                continue
            }
            if let js = JSCodeGenerator.elementJS(for: elementType, namespace: namespace) {
                try context.eval(js)
            }
        }
        return true
    }
}
