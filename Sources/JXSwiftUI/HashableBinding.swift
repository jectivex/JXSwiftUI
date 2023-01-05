import JXKit
import SwiftUI

/// We can't use `Binding<any Hashable>` in SwiftUI views like `Picker`, so switch on this enum instead.
enum HashableBinding {
    // Note: mirror the types supported by ForEachElement's id function
    case bool(Binding<Bool>)
    case date(Binding<Date>)
    case double(Binding<Double>)
    case string(Binding<String>)
    case hashable(Binding<AnyHashable>)
}

extension HashableBinding: JXConvertible {
    public static func fromJX(_ value: JXValue) throws -> HashableBinding {
        guard try value["get"].isFunction else {
            throw JXError(message: "Expected a JavaScript binding but received '\(value)'")
        }
        let currentValue = try value["get"].call()
        if currentValue.isBoolean {
            return try .bool(Binding<Bool>.fromJX(value))
        } else if currentValue.isNumber {
            return try .double(Binding<Double>.fromJX(value))
        } else if currentValue.isString {
            return try .string(Binding<String>.fromJX(value))
        } else if try currentValue.bridged != nil {
            return try .hashable(Binding<AnyHashable>.fromJX(value))
        } else if try currentValue.isDate {
            // Check this last because it is the most expensive to test
            return try .date(Binding<Date>.fromJX(value))
        } else {
            return try .string(Binding<String>.fromJX(value))
        }
    }

    public func toJX(in context: JXContext) throws -> JXValue {
        switch self {
        case .bool(let binding):
            return try context.convey(binding)
        case .date(let binding):
            return try context.convey(binding)
        case .double(let binding):
            return try context.convey(binding)
        case .string(let binding):
            return try context.convey(binding)
        case .hashable(let binding):
            return try context.convey(binding)
        }
    }
}
