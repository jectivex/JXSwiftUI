import JXKit
import SwiftUI

/// A view that iterates over a collection of items.
struct ForEachView: View {
    let info: ForEachInfo
    let errorHandler: ErrorHandler?

    var body: some View {
        ForEach(itemsWithIdentity, id: \.id) { itemWithIdentity in
            contentInfo(for: itemWithIdentity.item).view(errorHandler: errorHandler)
        }
    }

    private var itemsWithIdentity: ItemWithIdentityCollection {
        do {
            return try ItemWithIdentityCollection(items: info.items) { item in
                do {
                    return try info.id(for: item)
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

    private func contentInfo(for item: Any) -> ElementInfo {
        do {
            return try info.contentInfo(for: item)
        } catch {
            errorHandler?(error)
            return EmptyInfo()
        }
    }
}

struct ForEachInfo: ElementInfo {
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
        return try Self.info(for: content, in: elementType)
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
