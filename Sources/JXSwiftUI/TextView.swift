//
//  TextView.swift
//
//  Created by Abe White on 9/26/22.
//

import SwiftUI

public protocol TextInfo: ScriptElementInfo {
    var text: String { get throws }
}

/**
 A view whose body is a `SwiftUI.Text` view.
 */
public struct TextView: View {
    private let _info: TextInfo

    public init(_ info: TextInfo) {
        _info = info
    }

    public var body: some View {
        Text(_text)
    }

    private var _text: String {
        do {
            return try _info.text
        } catch {
            // TODO: Error handler
            return ""
        }
    }
}
