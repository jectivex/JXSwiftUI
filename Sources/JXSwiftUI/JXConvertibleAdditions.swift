import JXBridge
import JXKit
import SwiftUI

extension Binding: JXConvertible {
    public static func fromJX(_ value: JXValue) throws -> Binding<Value> {
        guard try value["get"].isFunction && value["set"].isFunction else {
            throw JXError(message: "Expected a JavaScript binding but received '\(value)'")
        }
        return Binding() {
            do {
                let ret = try value["get"].call()
                return try ret.convey(to: Value.self)
            } catch {
                // Is there anything else we could possibly do here?
                fatalError("Fatal: Caught an error invoking a JavaScript function conveyed to a Binding. \(String(describing: error))")
            }
        } set: {
            do {
                let arg = try value.context.convey($0)
                try value["set"].call(withArguments: [arg])
            } catch {
                // Is there anything else we could possibly do here?
                fatalError("Fatal: Caught an error invoking a JavaScript function conveyed to a Binding. \(String(describing: error))")
            }
        }
    }
    
    public func toJX(in context: JXContext) throws -> JXValue {
        let get = JXValue(newFunctionIn: context) { context, this, args in
            return try context.convey(self.wrappedValue)
        }
        let set = JXValue(newFunctionIn: context) { context, this, args in
            guard args.count == 1 else {
                return context.undefined()
            }
            self.wrappedValue = try args[0].convey(to: Value.self)
            return context.undefined()
        }
        return try context.global[JSCodeGenerator.bindingClass][JSCodeGenerator.bindingClassCreateFunction].call(withArguments: [get, set])
    }
}

extension JXSwiftUISupport {
    /// Use a JavaScript string to name any `SwiftUI.Edge` value, e.g. `'top'`.
    public enum Edge {}
}

/// - Note: `Edge` already conforms to `RawRepresentable` as a number, so use `JXConvertible` for readable string values.
extension Edge: JXConvertible {
    public static func fromJX(_ value: JXValue) throws -> Edge {
        switch try value.string {
        case "top":
            return .top
        case "bottom":
            return .bottom
        case "leading":
            return .leading
        case "trailing":
            return .trailing
        default:
            throw JXError(message: "'\(try value.string)' is not a valid 'Edge' value")
        }
    }
    
    public func toJX(in context: JXContext) throws -> JXValue {
        switch self {
        case .top:
            return context.string("top")
        case .bottom:
            return context.string("bottom")
        case .leading:
            return context.string("leading")
        case .trailing:
            return context.string("trailing")
        }
    }
}

extension JXSwiftUISupport {
    /// Use a JavaScript object with `top`, `bottom`, `leading`, `trailing` properties to represent `SwiftUI.EdgeInsets`.
    public enum EdgeInsets {}
}

extension EdgeInsets: JXConvertible {
    public static func fromJX(_ value: JXValue) throws -> EdgeInsets {
        return try EdgeInsets(top: value["top"].double, leading: value["leading"].double, bottom: value["bottom"].double, trailing: value["trailing"].double)
    }
    
    public func toJX(in context: JXContext) throws -> JXValue {
        return try context.object(fromDictionary: [
            "top": top, "leading": leading, "bottom": bottom, "trailing": trailing
        ])
    }
}

extension JXSwiftUISupport {
    /// Use a JavaScript string to name any `SwiftUI.Axis` value, e.g. `'horizontal'`.
    public enum Axis {}
}

/// - Note: `Axis` already conforms to `RawRepresentable` as a number, so use `JXConvertible` for readable string values.
extension Axis: JXConvertible {
    public static func fromJX(_ value: JXValue) throws -> Axis {
        switch try value.string {
        case "horizontal":
            return .horizontal
        case "vertical":
            return .vertical
        default:
            throw JXError(message: "'\(try value.string)' is not a valid 'Axis' value")
        }
    }
    
    public func toJX(in context: JXContext) throws -> JXValue {
        switch self {
        case .horizontal:
            return context.string("horizontal")
        case .vertical:
            return context.string("vertical")
        }
    }
}
