import JXBridge
import JXKit
import SwiftUI

extension JXSwiftUISupport {
    /// A `SwiftUI.ForEach` view.
    ///
    /// Supported usage:
    ///
    ///     - ForEach([items], (item) => { itemId }, (item) => { content })
    ///     - ForEach([items], 'id', (item) => { content })
    ///     - ForEach([items], (item) => { content })
    ///
    /// Item IDs can be booleans, strings, numbers, symbols, or dates. Supported ways of getting each item ID:
    ///
    ///     - (item) => { itemId }: A function accepting an item and returning its ID
    ///     - 'id': The name of a property holding each item's ID
    ///     - If omitted, we assume each item has an 'id' property
    ///
    /// Supported `content`:
    ///
    ///     - (item) => { content }: A function accepting an item and returning a View
    public enum ForEach {}
}

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
        self.contentFunction = try jxValue["content"]
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
function(items, idOrContent, content) {
    const e = new \(JXNamespace.default).\(JSCodeGenerator.elementClass)('\(ElementType.foreach.rawValue)');
    e.items = items;
    if (content === undefined) {
        e.idFunction = (item) => { return item.id; }
        e.content = idOrContent;
    } else {
        if (typeof(idOrContent) === 'string') {
            e.idFunction = (item) => { return item[idOrContent]; }
        } else {
            e.idFunction = idOrContent;
        }
        e.content = content;
    }
    return e;
}
"""
    }
    
    private func contentElement(for item: Any, errorHandler: ErrorHandler?) -> Element {
        do {
            let content = try contentFunction.call(withArguments: [item as! JXValue])
            return try Content(jxValue: content).element(errorHandler: errorHandler)
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
