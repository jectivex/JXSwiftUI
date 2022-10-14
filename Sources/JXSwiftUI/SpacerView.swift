//
//  SpacerView.swift
//
//  Created by Abe White on 9/28/22.
//

import SwiftUI

public protocol SpacerInfo: ScriptElementInfo {
}

/**
 A view whose body is a `SwiftUI.Spacer` view.
 */
public struct SpacerView: View {
    private let _info: SpacerInfo

    public init(_ info: SpacerInfo) {
        _info = info
    }

    public var body: some View {
        Spacer()
    }
}
