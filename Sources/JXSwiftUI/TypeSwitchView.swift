import SwiftUI

/// View whose body is based on the `ElementType` of the given content info.
struct TypeSwitchView: View {
    let info: ElementInfo
    let errorHandler: ErrorHandler?

    var body: some View {
        switch info.elementType {
        case .button:
            ButtonView(info: info as! ButtonInfo, errorHandler: errorHandler)
        case .custom:
            CustomView(info: info as! CustomInfo, errorHandler: errorHandler)
        case .empty:
            EmptyView()
        case .foreach:
            ForEachView(info: info as! ForEachInfo, errorHandler: errorHandler)
        case .hstack:
            HStackView(info: info as! HStackInfo, errorHandler: errorHandler)
        case .if:
            IfView(info: info as! IfInfo, errorHandler: errorHandler)
        case .list:
            ListView(info: info as! ListInfo, errorHandler: errorHandler)
        case .navigationView:
            NavigationView(info: info as! NavigationViewInfo, errorHandler: errorHandler)
        case .spacer:
            SpacerView(info: info as! SpacerInfo, errorHandler: errorHandler)
        case .text:
            TextView(info: info as! TextInfo, errorHandler: errorHandler)
        case .unknown:
            EmptyView()
        case .vstack:
            VStackView(info: info as! VStackInfo, errorHandler: errorHandler)

        case .fontModifier:
            FontModifierView(info: info as! FontModifierInfo, errorHandler: errorHandler)
        case .navigationTitleModifier:
            NavigationTitleModifierView(info: info as! NavigationTitleModifierInfo, errorHandler: errorHandler)
        case .tapGestureModifier:
            TapGestureModifierView(info: info as! TapGestureModifierInfo, errorHandler: errorHandler)
        }
    }
}
