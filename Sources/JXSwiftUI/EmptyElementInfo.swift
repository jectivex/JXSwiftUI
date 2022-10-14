//
//  EmptyElementInfo.swift
//
//  Created by Abe White on 10/5/22.
//

/**
 Info for an empty view.
 */
public struct EmptyElementInfo: ScriptElementInfo {
    public init() {
    }
    
    public var elementType: ScriptElementType {
        return .empty
    }
}
