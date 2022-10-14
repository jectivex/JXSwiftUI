//
//  ForEachView.swift
//
//  Created by Abe White on 9/28/22.
//

import SwiftUI

public protocol ForEachInfo: ScriptElementInfo {
    var items: AnyRandomAccessCollection<Any> { get throws }
    func id(for item: Any) throws -> AnyHashable
    func contentInfo(for item: Any) throws -> ScriptElementInfo
}

/**
 A view that iterates over a collection of items.
 */
public struct ForEachView: View {
    private let _info: ForEachInfo

    public init(_ info: ForEachInfo) {
        _info = info
    }

    public var body: some View {
        ForEach(_itemsWithIdentity, id: \.id) { itemWithIdentity in
            TypeSwitchView(_contentInfo(for: itemWithIdentity.item))
        }
    }

    private var _itemsWithIdentity: _ItemWithIdentityCollection {
        do {
            return try _ItemWithIdentityCollection(items: _info.items) { item in
                do {
                    return try _info.id(for: item)
                } catch {
                    // TODO: Error handling
                    return ""
                }
            }
        } catch {
            // TODO: Error handling
            return _ItemWithIdentityCollection(items: AnyRandomAccessCollection([])) { _ in "" }
        }
    }

    private func _contentInfo(for item: Any) -> ScriptElementInfo {
        do {
            return try _info.contentInfo(for: item)
        } catch {
            // TODO: Error handling
            return EmptyElementInfo()
        }
    }
}

private struct _ItemWithIdentityCollection: RandomAccessCollection {
    let items: AnyRandomAccessCollection<Any>
    let idFunction: (Any) -> AnyHashable

    var startIndex: AnyIndex {
        return self.items.startIndex
    }

    var endIndex: AnyIndex {
        return self.items.endIndex
    }

    func index(after index: AnyIndex) -> AnyIndex {
        return self.items.index(after: index)
    }

    func index(before index: AnyIndex) -> AnyIndex {
        return self.items.index(before: index)
    }

    subscript(index: AnyIndex) -> (id: AnyHashable, item: Any) {
        let item = self.items[index]
        let id = self.idFunction(item)
        return (id, item)
    }
}
