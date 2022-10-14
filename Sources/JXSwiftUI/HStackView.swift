//
//  HStackView.swift
//
//  Created by Abe White on 9/28/22.
//

import SwiftUI

public protocol HStackInfo: ScriptElementInfo {
    var contentInfo: [ScriptElementInfo] { get throws }
}

/**
 A view whose body is a `SwiftUI.HStack` view.
 */
public struct HStackView: View {
    private let _info: HStackInfo

    public init(_ info: HStackInfo) {
        _info = info
    }

    public var body: some View {
        HStack {
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
