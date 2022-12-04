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
        return try context.new(JSCodeGenerator.bindingClass, withArguments: [get, set])
    }
}
