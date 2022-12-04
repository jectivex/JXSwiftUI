import JXBridge
import JXKit
import SwiftUI

/// Iterates over a collection of items.
struct ForEachElement: Element {
    private let itemsValue: JXValue
    private let idFunction: JXValue
    private let contentFunction: JXValue

    init(jxValue: JXValue) throws {
        self.itemsValue = try jxValue["items"]
        guard itemsValue.isArray else {
            throw JXError(message: "Expected an array of items to iterate over. Received '\(itemsValue)'")
        }
        self.idFunction = try jxValue["idFunction"]
        guard idFunction.isFunction else {
            throw JXError(message: "Expected a function that takes an item as its argument and returns the item's identifier. Received '\(idFunction)'")
        }
        self.contentFunction = try jxValue["contentFunction"]
        guard contentFunction.isFunction else {
            throw JXError(message: "Content must be a function. Received '\(contentFunction)'")
        }
    }

    func view(errorHandler: ErrorHandler?) -> any View {
        let errorHandler = errorHandler?.in(.foreach)
        return ForEach(itemsWithIdentity(errorHandler: errorHandler), id: \.id) { itemWithIdentity in
            let contentElement = contentElement(for: itemWithIdentity.item, errorHandler: errorHandler)
            return contentElement.view(errorHandler: errorHandler)
                .eraseToAnyView()
        }
    }
    
    static func js(namespace: JXNamespace) -> String? {
        """
function(items, idFunction, contentFunction) {
    const e = new \(namespace).JXElement('\(ElementType.foreach.rawValue)');
    e.items = items;
    e.idFunction = idFunction;
    e.contentFunction = contentFunction;
    return e;
}
"""
    }
    
    private func contentElement(for item: Any, errorHandler: ErrorHandler?) -> Element {
        do {
            let content = try contentFunction.call(withArguments: [item as! JXValue])
            return Content(jxValue: content).element(errorHandler: errorHandler)
        } catch {
            errorHandler?.handle(error)
            return EmptyElement()
        }
    }
    
    private func itemsWithIdentity(errorHandler: ErrorHandler?) -> ItemWithIdentityCollection {
        do {
            return try ItemWithIdentityCollection(items: items) { item in
                do {
                    return try id(for: item)
                } catch {
                    errorHandler?.handle(error)
                    return 0
                }
            }
        } catch {
            errorHandler?.handle(error)
            return ItemWithIdentityCollection(items: AnyRandomAccessCollection([])) { _ in 0 }
        }
    }

    private var items: AnyRandomAccessCollection<Any> {
        get throws {
            let jxItems = try itemsValue.array
            return AnyRandomAccessCollection(jxItems)
        }
    }

    private func id(for item: Any) throws -> AnyHashable {
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
        case .arrayBuffer:
            break
        case .string:
            return try idValue.string
        case .array:
            break
        case .object:
            break
        case .symbol:
            return try idValue.string
        case .promise:
            break
        case .error:
            break
        case .constructor:
            break
        case .function:
            break
        case .other:
            break
        }
        throw JXError(message: "Unable to use value '\(idValue)' as an item identifier")
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
