import JXBridge
import JXKit
import SwiftUI

/// Iterates over a collection of items.
struct ForEachInfo: ElementInfo {
    private let itemsValue: JXValue
    private let idFunction: JXValue
    private let contentFunction: JXValue

    init(jxValue: JXValue) throws {
        self.itemsValue = try jxValue["items"]
        self.idFunction = try jxValue["idFunction"]
        self.contentFunction = try jxValue["contentFunction"]
        if !contentFunction.isFunction {
            throw JXSwiftUIErrors.valueNotFunction(elementType.rawValue, "contentFunction")
        }
    }

    var elementType: ElementType {
        return .foreach
    }

    @ViewBuilder
    func view(errorHandler: ErrorHandler?) -> any View {
        ForEach(itemsWithIdentity(errorHandler: errorHandler), id: \.id) { itemWithIdentity in
            let contentInfo = contentInfo(for: itemWithIdentity.item, errorHandler: errorHandler)
            AnyView(contentInfo.view(errorHandler: errorHandler))
        }
    }
    
    static func js(namespace: JXNamespace) -> String? {
        """
function(items, idFunction, contentFunction) {
    const e = new \(namespace.value).JXElement('\(ElementType.foreach.rawValue)');
    e.items = items;
    e.idFunction = idFunction;
    e.contentFunction = contentFunction;
    return e;
}
"""
    }
    
    private func contentInfo(for item: Any, errorHandler: ErrorHandler?) -> ElementInfo {
        do {
            let content = try contentFunction.call(withArguments: [item as! JXValue])
            return try Self.info(for: content, in: elementType)
        } catch {
            errorHandler?(error)
            return EmptyInfo()
        }
    }
    
    private func itemsWithIdentity(errorHandler: ErrorHandler?) -> ItemWithIdentityCollection {
        do {
            return try ItemWithIdentityCollection(items: items) { item in
                do {
                    return try id(for: item)
                } catch {
                    errorHandler?(error)
                    return ""
                }
            }
        } catch {
            errorHandler?(error)
            return ItemWithIdentityCollection(items: AnyRandomAccessCollection([])) { _ in "" }
        }
    }

    private var items: AnyRandomAccessCollection<Any> {
        get throws {
            guard itemsValue.isArray else {
                throw JXSwiftUIErrors.valueNotArray(elementType.rawValue, "items")
            }
            let jxItems = try itemsValue.array
            return AnyRandomAccessCollection(jxItems)
        }
    }

    private func id(for item: Any) throws -> AnyHashable {
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
}

private struct ItemWithIdentityCollection: RandomAccessCollection {
    let items: AnyRandomAccessCollection<Any>
    let idFunction: (Any) -> AnyHashable

    var startIndex: AnyIndex {
        return items.startIndex
    }

    var endIndex: AnyIndex {
        return items.endIndex
    }

    func index(after index: AnyIndex) -> AnyIndex {
        return items.index(after: index)
    }

    func index(before index: AnyIndex) -> AnyIndex {
        return items.index(before: index)
    }

    subscript(index: AnyIndex) -> (id: AnyHashable, item: Any) {
        let item = items[index]
        let id = idFunction(item)
        return (id, item)
    }
}
