import Combine
import JXBridge
import JXKit
import SwiftUI

extension JXNamespace {
    /// Default JXSwiftUI namespace.
    public static var jxswiftui = JXNamespace("jxswiftui")
}

/// Register this module to use SwiftUI in a `JXContext`.
public struct JXSwiftUI: JXModule {
    public init() {
    }
    
    public let namespace: JXNamespace = JXNamespace.jxswiftui
    
    public func initialize(in context: JXContext) throws {
        // Function elements trigger to load a modifier that the code has called but does not yet exist
        let addModifierFunction = JXValue(newFunctionIn: context) { context, this, args in
            guard args.count == 1 else {
                return context.undefined()
            }
            let modifier = try args[0].string
            if let elementType = ElementType(rawValue: modifier), let js = JSCodeGenerator.modifierJS(for: elementType, modifier: modifier, namespace: namespace) {
                try context.eval(js)
            }
            return context.undefined()
        }
        try context.global[namespace].setProperty(JSCodeGenerator.addModifierFunction, addModifierFunction)
        
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
        if let elementType = ElementType(rawValue: symbol), let js = JSCodeGenerator.elementJS(for: elementType, namespace: namespace) {
            try context.eval(js)
            return true
        }
        if let symbol = SwiftUISymbol(rawValue: symbol) {
            try symbol.define(in: context, namespace: namespace)
            return true
        }
        return false
    }
    
    public func define(for instance: Any, in context: JXContext) throws -> Bool {
        for symbol in SwiftUISymbol.allCases {
            if symbol.isInstance(instance) {
                try symbol.define(in: context, namespace: namespace)
                return true
            }
        }
        return false
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
        for symbol in SwiftUISymbol.allCases {
            guard !namespaceValue.hasProperty(symbol.rawValue) else {
                continue
            }
            try symbol.define(in: context, namespace: namespace)
        }
        return true
    }
}
    
// Non-Element symbols
private enum SwiftUISymbol: String, CaseIterable {
    case color = "Color"
    case font = "Font"
    
    func isInstance(_ instance: Any) -> Bool {
        switch self {
        case .color:
            return instance is Color
        case .font:
            return instance is Font
        }
    }
    
    func define(in context: JXContext, namespace: JXNamespace) throws {
        switch self {
        case .color:
            try context.registry.registerBridge(for: Color.self, namespace: namespace)
        case .font:
            try context.registry.registerBridge(for: Font.self, namespace: namespace)
        }
    }
}
