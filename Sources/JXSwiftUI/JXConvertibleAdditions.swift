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
    /// Use a JavaScript string to name any `SwiftUI.Edge.Set` value, e.g. `'top'`.
    public enum EdgeSet {}
}

/// - Note: `Edge` already conforms to `RawRepresentable` as a number, so use `JXConvertible` for readable string values.
extension Edge.Set: JXConvertible {
    public static func fromJX(_ value: JXValue) throws -> Edge.Set {
        guard !value.isString else {
            return try fromString(value.string)
        }
        guard value.isArray else {
            throw JXError(message: "'\(value)' is neither a 'Edge.Set' string nor an array of 'Edge.Set' strings")
        }
        return try value.array.reduce(into: Edge.Set()) { result, value in
            try result.insert(fromString(value.string))
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
        case .all:
            return context.string("all")
        case .horizontal:
            return context.string("horizontal")
        case .vertical:
            return context.string("vertical")
        default:
            let array: [Edge.Set] = [.top, .bottom, .leading, .trailing].filter { self.contains($0) }
            return try context.array(array.map(Self.toString))
        }
    }

    private static func fromString(_ string: String) throws -> Edge.Set {
        switch string {
        case "top":
            return .top
        case "bottom":
            return .bottom
        case "leading":
            return .leading
        case "trailing":
            return .trailing
        case "all":
            return .all
        case "horizontal":
            return .horizontal
        case "vertical":
            return .vertical
        default:
            throw JXError(message: "'\(string)' is not a valid 'Edge.Set' value")
        }
    }

    private static func toString(_ value: Edge.Set) -> String {
        switch value {
        case .top:
            return "top"
        case .bottom:
            return "bottom"
        case .leading:
            return "leading"
        case .trailing:
            return "trailing"
        default:
            return "unknown"
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
