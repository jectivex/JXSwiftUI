//
//  CustomView.swift
//
//  Created by Abe White on 9/25/22.
//

import Combine
import SwiftUI

public protocol CustomInfo: ScriptElementInfo {
    var onChange: AnyPublisher<Void, Never> { get throws }
    var contentInfo: ScriptElementInfo { get throws }
}

/**
 A view with custom content defined by a script.
 */
public struct CustomView: View {
    private let _info: CustomInfo
    @StateObject private var _trigger = _Trigger()

    public init(_ info: CustomInfo) {
        _info = info
    }

    public var body: some View {
        TypeSwitchView(_contentInfo)
            .onReceive(_onChange) {
                withAnimation { _trigger.objectWillChange.send() }
            }
    }

    private var _onChange: AnyPublisher<Void, Never> {
        do {
            return try _info.onChange
        } catch {
            // TODO: Error handling
            return PassthroughSubject().eraseToAnyPublisher()
        }
    }

    private var _contentInfo: ScriptElementInfo {
        do {
            return try _info.contentInfo
        } catch {
            // TODO: Error handling
            return EmptyElementInfo()
        }
    }
}

private class _Trigger: ObservableObject {
}
