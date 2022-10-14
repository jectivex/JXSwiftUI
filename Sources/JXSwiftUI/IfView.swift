//
//  IfView.swift
//
//  Created by Abe White on 9/25/22.
//

import SwiftUI

public protocol IfInfo: ScriptElementInfo {
    var isTrue: Bool { get throws }
    var ifContentInfo: ScriptElementInfo { get throws }
    var elseContentInfo: ScriptElementInfo? { get throws }
}

/**
 A view that includes 'if' or 'else' content depending on a boolean condition.
 */
public struct IfView: View {
    private let _info: IfInfo

    public init(_ info: IfInfo) {
        _info = info
    }

    public var body: some View {
        if _isTrue {
            TypeSwitchView(_ifContentInfo)
        } else if let elseContentInfo = _elseContentInfo {
            TypeSwitchView(elseContentInfo)
        }
    }

    private var _isTrue: Bool {
        do {
            return try _info.isTrue
        } catch {
            // TODO: Error handling
            return false
        }
    }

    private var _ifContentInfo: ScriptElementInfo {
        do {
            return try _info.ifContentInfo
        } catch {
            // TODO: Error handling
            return EmptyElementInfo()
        }
    }

    private var _elseContentInfo: ScriptElementInfo? {
        do {
            return try _info.elseContentInfo
        } catch {
            // TODO: Error handling
            return nil
        }
    }
}
