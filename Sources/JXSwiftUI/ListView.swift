//
//  ListView.swift
//
//  Created by Abe White on 9/28/22.
//

import SwiftUI

public protocol ListInfo: ScriptElementInfo {
    var contentInfo: [ScriptElementInfo] { get throws }
}

/**
 A view whose body is a `SwiftUI.List` view.
 */
public struct ListView: View {
    private let _info: ListInfo

    public init(_ info: ListInfo) {
        _info = info
    }

    public var body: some View {
        List {
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
