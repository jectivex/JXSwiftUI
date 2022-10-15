//
//  TypeSwitchView.swift
//
//  Created by Abe White on 9/25/22.
//

import SwiftUI

/**
 View whose body is based on the `ElementType` of the given content info.
 */
struct TypeSwitchView: View {
    private let info: ElementInfo

    init(_ info: ElementInfo) {
        self.info = info
    }

    var body: some View {
        switch info.elementType {
        case .button:
            ButtonView(info as! ButtonInfo)
        case .custom:
            CustomView(info as! CustomInfo)
        case .empty:
            EmptyView()
        case .foreach:
            ForEachView(info as! ForEachInfo)
        case .hstack:
            HStackView(info as! HStackInfo)
        case .if:
            IfView(info as! IfInfo)
        case .list:
            ListView(info as! ListInfo)
        case .spacer:
            SpacerView(info as! SpacerInfo)
        case .text:
            TextView(info as! TextInfo)
        case .vstack:
            VStackView(info as! VStackInfo)

        case .fontModifier:
            FontModifierView(info as! FontModifierInfo)
        case .tapGestureModifier:
            TapGestureModifierView(info as! TapGestureModifierInfo)

        default:
            // TODO: Error handling
            EmptyView()
        }
    }
}
