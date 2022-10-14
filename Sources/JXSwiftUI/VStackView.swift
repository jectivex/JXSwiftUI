//
//  VStackView.swift
//
//  Created by Abe White on 9/26/22.
//

import SwiftUI

public protocol VStackInfo: ScriptElementInfo {
    var contentInfo: [ScriptElementInfo] { get throws }
}

/**
 A view whose body is a `SwiftUI.VStack` view.
 */
public struct VStackView: View {
    private let _info: VStackInfo

    public init(_ info: VStackInfo) {
        _info = info
    }

    public var body: some View {
        VStack {
            TypeSwitchView.content(for: _contentInfo)
        }
    }

    private var _contentInfo: [ScriptElementInfo] {
        do {
            return try _info.contentInfo
        } catch {
            // TODO: Error handling
            return []
        }
    }
}
