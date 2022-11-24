import JXKit

struct JXForEachInfo: ForEachInfo {
    private let itemsValue: JXValue
    private let idFunction: JXValue
    private let contentFunction: JXValue

    init(jxValue: JXValue) throws {
        self.itemsValue = try jxValue["items"]
        self.idFunction = try jxValue["idFunction"]
        self.contentFunction = try jxValue["contentFunction"]
    }

    var elementType: ElementType {
        return .foreach
    }

    var items: AnyRandomAccessCollection<Any> {
        get throws {
            guard itemsValue.isArray else {
                throw JXSwiftUIErrors.valueNotArray(elementType.rawValue, "items")
            }
            let jxItems = try itemsValue.array
            return AnyRandomAccessCollection(jxItems)
        }
    }

    func id(for item: Any) throws -> AnyHashable {
        guard idFunction.isFunction else {
            throw JXSwiftUIErrors.valueNotFunction(elementType.rawValue, "idFunction")
        }
        let idValue = try idFunction.call(withArguments: [item as! JXValue])
        switch idValue.type {
        case .null:
            return 0
        case .undefined:
            return 0
        case .boolean:
            return idValue.bool
        case .number:
            return try idValue.double
        case .date:
            return try idValue.date
        case .buffer:
            break
        case .string:
            return try idValue.string
        case .array:
            break
        case .object:
            break
        case .symbol:
            return try idValue.string
        case .other:
            break
        }
        throw JXSwiftUIErrors.unknownValue(elementType.rawValue, "idFunction")
    }

    func contentInfo(for item: Any) throws -> ElementInfo {
        guard contentFunction.isFunction else {
            throw JXSwiftUIErrors.valueNotFunction(elementType.rawValue, "contentFunction")
        }
        let content = try contentFunction.call(withArguments: [item as! JXValue])
        return try JXElementInfo.info(for: content, in: elementType)
    }
}
