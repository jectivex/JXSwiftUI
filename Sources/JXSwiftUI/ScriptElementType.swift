//
//  ScriptElementType.swift
//
//  Created by Abe White on 9/25/22.
//

/**
 All supported UI element types.
 */
public enum ScriptElementType: String {
    // Views
    case button
    case custom
    case empty
    case foreach
    case hstack
    case list
    case `if`
    case spacer
    case text
    case vstack
    case unknown

    // Modifiers
    case fontModifier
    case tapGestureModifier
}
