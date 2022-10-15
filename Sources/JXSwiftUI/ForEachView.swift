import SwiftUI

protocol ForEachInfo: ElementInfo {
    var items: AnyRandomAccessCollection<Any> { get throws }
    func id(for item: Any) throws -> AnyHashable
    func contentInfo(for item: Any) throws -> ElementInfo
}

/// A view that iterates over a collection of items.
struct ForEachView: View {
    private let info: ForEachInfo

    init(_ info: ForEachInfo) {
        self.info = info
    }

    var body: some View {
        ForEach(itemsWithIdentity, id: \.id) { itemWithIdentity in
            contentInfo(for: itemWithIdentity.item).view
        }
    }

    private var itemsWithIdentity: ItemWithIdentityCollection {
        do {
            return try ItemWithIdentityCollection(items: info.items) { item in
                do {
                    return try info.id(for: item)
                } catch {
                    // TODO: Error handling
                    return ""
                }
            }
        } catch {
            // TODO: Error handling
            return ItemWithIdentityCollection(items: AnyRandomAccessCollection([])) { _ in "" }
        }
    }

    private func contentInfo(for item: Any) -> ElementInfo {
        do {
            return try info.contentInfo(for: item)
        } catch {
            // TODO: Error handling
            return EmptyInfo()
        }
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
