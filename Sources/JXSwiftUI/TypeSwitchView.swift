//
//  TypeSwitchView.swift
//
//  Created by Abe White on 9/25/22.
//

import SwiftUI

/**
 View whose body is based on the `ScriptElementType` of the given content info.
 */
public struct TypeSwitchView: View {
    private let _info: ScriptElementInfo

    public init(_ info: ScriptElementInfo) {
        _info = info
    }

    public var body: some View {
        switch _info.elementType {
        case .button:
            ButtonView(_info as! ButtonInfo)
        case .custom:
            CustomView(_info as! CustomInfo)
        case .empty:
            EmptyView()
        case .foreach:
            ForEachView(_info as! ForEachInfo)
        case .hstack:
            HStackView(_info as! HStackInfo)
        case .if:
            IfView(_info as! IfInfo)
        case .list:
            ListView(_info as! ListInfo)
        case .spacer:
            SpacerView(_info as! SpacerInfo)
        case .text:
            TextView(_info as! TextInfo)
        case .vstack:
            VStackView(_info as! VStackInfo)

        case .fontModifier:
            FontModifierView(_info as! FontModifierInfo)
        case .tapGestureModifier:
            TapGestureModifierView(_info as! TapGestureModifierInfo)

        default:
            // TODO: Error handling
            EmptyView()
        }
    }

    @ViewBuilder
    static func content(for contentInfo: [ScriptElementInfo]) -> some View {
        // NOTE: ForEach caused a blank view followed by a crash after minutes
        // of no activity, so fallback to brute force
        switch contentInfo.count {
        case 0:
            Group {
            }
        case 1:
            TypeSwitchView(contentInfo[0])
        case 2:
            Group  {
                TypeSwitchView(contentInfo[0])
                TypeSwitchView(contentInfo[1])
            }
        case 3:
            Group  {
                TypeSwitchView(contentInfo[0])
                TypeSwitchView(contentInfo[1])
                TypeSwitchView(contentInfo[2])
            }
        case 4:
            Group  {
                TypeSwitchView(contentInfo[0])
                TypeSwitchView(contentInfo[1])
                TypeSwitchView(contentInfo[2])
                TypeSwitchView(contentInfo[3])
            }
        case 5:
            Group  {
                TypeSwitchView(contentInfo[0])
                TypeSwitchView(contentInfo[1])
                TypeSwitchView(contentInfo[2])
                TypeSwitchView(contentInfo[3])
                TypeSwitchView(contentInfo[4])
            }
        case 6:
            Group  {
                TypeSwitchView(contentInfo[0])
                TypeSwitchView(contentInfo[1])
                TypeSwitchView(contentInfo[2])
                TypeSwitchView(contentInfo[3])
                TypeSwitchView(contentInfo[4])
                TypeSwitchView(contentInfo[5])
            }
        case 7:
            Group  {
                TypeSwitchView(contentInfo[0])
                TypeSwitchView(contentInfo[1])
                TypeSwitchView(contentInfo[2])
                TypeSwitchView(contentInfo[3])
                TypeSwitchView(contentInfo[4])
                TypeSwitchView(contentInfo[5])
                TypeSwitchView(contentInfo[6])
            }
        case 8:
            Group  {
                TypeSwitchView(contentInfo[0])
                TypeSwitchView(contentInfo[1])
                TypeSwitchView(contentInfo[2])
                TypeSwitchView(contentInfo[3])
                TypeSwitchView(contentInfo[4])
                TypeSwitchView(contentInfo[5])
                TypeSwitchView(contentInfo[6])
                TypeSwitchView(contentInfo[7])
            }
        case 9:
            Group  {
                TypeSwitchView(contentInfo[0])
                TypeSwitchView(contentInfo[1])
                TypeSwitchView(contentInfo[2])
                TypeSwitchView(contentInfo[3])
                TypeSwitchView(contentInfo[4])
                TypeSwitchView(contentInfo[5])
                TypeSwitchView(contentInfo[6])
                TypeSwitchView(contentInfo[7])
                TypeSwitchView(contentInfo[8])
            }
        case 10:
            Group  {
                TypeSwitchView(contentInfo[0])
                TypeSwitchView(contentInfo[1])
                TypeSwitchView(contentInfo[2])
                TypeSwitchView(contentInfo[3])
                TypeSwitchView(contentInfo[4])
                TypeSwitchView(contentInfo[5])
                TypeSwitchView(contentInfo[6])
                TypeSwitchView(contentInfo[7])
                TypeSwitchView(contentInfo[8])
                TypeSwitchView(contentInfo[9])
            }
        default:
            Group {
                // TODO: Error handling
                EmptyView()
            }
        }
    }
}
