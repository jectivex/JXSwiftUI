//
//  JSForEachInfo.swift
//
//  Created by Abe White on 9/28/22.
//

import JXKit
import ScriptUI

struct JSForEachInfo: ForEachInfo {
    private let _itemsValue: JXValue
    private let _idFunction: JXValue
    private let _contentFunction: JXValue

    init(jxValue: JXValue) throws {
        _itemsValue = try jxValue["items"]
        _idFunction = try jxValue["idFunction"]
        _contentFunction = try jxValue["contentFunction"]
    }

    var elementType: ScriptElementType {
        return .foreach
    }

    var items: AnyRandomAccessCollection<Any> {
        get throws {
            guard try _itemsValue.isArray else {
                // TODO: Informative error
                return AnyRandomAccessCollection([])
            }
            let jxItems = try _itemsValue.array
            return AnyRandomAccessCollection(jxItems)
        }
    }

    func id(for item: Any) throws -> AnyHashable {
        guard _idFunction.isFunction else {
            // TODO: Throw informative error
            return 0
        }
        let idValue = try _idFunction.call(withArguments: [item as! JXValue])
        guard let type = idValue.type else {
            return 0
        }
        switch type {
        case .boolean:
            return idValue.booleanValue
        case .number:
            return try idValue.numberValue
        case .date:
            return try idValue.dateValue
        case .buffer:
            // TODO: Error
            return 0
        case .string:
            return try idValue.stringValue
        case .array:
            // TODO
            return 0
        case .object:
            // TODO: Handle dictionaries and mapped types
            return 0
        case .symbol:
            return try idValue.stringValue
        }
    }

    func contentInfo(for item: Any) throws -> ScriptElementInfo {
        guard _contentFunction.isFunction else {
            // TODO: Informative error
            return EmptyElementInfo()
        }
        let content = try _contentFunction.call(withArguments: [item as! JXValue])
        return try JXElementInfo.content(for: content, in: "ForEach")
    }
}
