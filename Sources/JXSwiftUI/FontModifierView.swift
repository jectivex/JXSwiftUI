//
//  FontModifierView.swift
//
//  Created by Abe White on 9/28/22.
//

import SwiftUI

public protocol FontModifierInfo: ScriptElementInfo {
    var targetInfo: ScriptElementInfo { get throws }
    var font: Font { get throws }
}

/**
 A view that specifies a font for its target view.
 */
public struct FontModifierView: View {
    private let _info: FontModifierInfo

    public init(_ info: FontModifierInfo) {
        _info = info
    }

    public var body: some View {
        TypeSwitchView(_targetInfo)
            .font(_font)
    }

    private var _targetInfo: ScriptElementInfo {
        do {
            return try _info.targetInfo
        } catch {
            // TODO: Error handling
            return EmptyElementInfo()
        }
    }

    private var _font: Font {
        do {
            return try _info.font
        } catch {
            // TODO: Error handling
            return .body
        }
    }
}
