//
//  TapGestureModifierView.swift
//
//  Created by Abe White on 9/26/22.
//

import SwiftUI

public protocol TapGestureModifierInfo: ScriptElementInfo {
    var targetInfo: ScriptElementInfo { get throws }
    func onTapGesture() throws
}

/**
 A view that adds a tap gesture to its target view.
 */
public struct TapGestureModifierView: View {
    private let _info: TapGestureModifierInfo

    public init(_ info: TapGestureModifierInfo) {
        _info = info
    }

    public var body: some View {
        TypeSwitchView(_targetInfo)
            .onTapGesture {
                _onTapGesture()
            }
    }

    private var _targetInfo: ScriptElementInfo {
        do {
            return try _info.targetInfo
        } catch {
            // TODO: Error handling
            return EmptyElementInfo()
        }
    }

    private func _onTapGesture() {
        do {
            try _info.onTapGesture()
        } catch {
            // TODO: Error handling
        }
    }
}
