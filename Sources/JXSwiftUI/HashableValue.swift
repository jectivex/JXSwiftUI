import JXKit
import SwiftUI

/// We can't use `any Hashable` in SwiftUI modifiers like `tag`, so switch on this enum instead.
enum HashableValue {
    // Note: mirror the types supported by ForEachElement's id function
    case bool(Bool)
    case date(Date)
    case double(Double)
    case string(String)
    case hashable(AnyHashable)
}

extension HashableValue: JXConvertible {
    public static func fromJX(_ value: JXValue) throws -> HashableValue {
        if value.isBoolean {
            return .bool(value.bool)
        } else if value.isNumber {
            return try .double(value.double)
        } else if value.isString {
            return try .string(value.string)
        } else if let hashable = try value.bridged as? AnyHashable {
            return .hashable(hashable)
        } else if try value.isDate {
            // Check this last because it is the most expensive to test
            return try .date(value.date)
        } else {
            return try .string(value.string)
        }
    }

    public func toJX(in context: JXContext) throws -> JXValue {
        switch self {
        case .bool(let value):
            return context.boolean(value)
        case .date(let value):
            return try context.date(value)
        case .double(let value):
            return context.number(value)
        case .string(let value):
            return context.string(value)
        case .hashable(let value):
            return try context.convey(value)
        }
    }
}
