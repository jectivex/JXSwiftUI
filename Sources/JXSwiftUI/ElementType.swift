/// All supported UI element types.
///
/// - Note: Raw values are equal to JS function names.
enum ElementType: String, CaseIterable {
    // Views
    case button = "Button"
    case custom
    case empty = "EmptyView"
    case foreach = "ForEach"
    case form = "Form"
    case group = "Group"
    case hstack = "HStack"
    case `if` = "If"
    case list = "List"
    case native
    case navigationLink = "NavigationLink"
    case navigationView = "NavigationView"
    case scrollView = "ScrollView"
    case section = "Section"
    case slider = "Slider"
    case spacer = "Spacer"
    case text = "Text"
    case vstack = "VStack"
    case unknown

    // Modifiers
    case backgroundModifier = "background"
    case fontModifier = "font"
    case foregroundColorModifier = "foregroundColor"
    case frameModifier = "frame"
    case navigationTitleModifier = "navigationTitle"
    case paddingModifier = "padding"
    case tapGestureModifier = "onTapGesture"
    
    var valueType: Element.Type? {
        switch self {
        case .button:
            return ButtonElement.self
        case .custom:
            return CustomElement.self
        case .empty:
            return EmptyElement.self
        case .foreach:
            return ForEachElement.self
        case .form:
            return FormElement.self
        case .group:
            return GroupElement.self
        case .hstack:
            return HStackElement.self
        case .if:
            return IfElement.self
        case .list:
            return ListElement.self
        case .native:
            return NativeElement.self
        case .navigationLink:
            return NavigationLinkElement.self
        case .navigationView:
            return NavigationViewElement.self
        case .scrollView:
            return ScrollViewElement.self
        case .section:
            return SectionElement.self
        case .slider:
            return SliderElement.self
        case .spacer:
            return SpacerElement.self
        case .text:
            return TextElement.self
        case .vstack:
            return VStackElement.self
            
        case .backgroundModifier:
            return BackgroundModifier.self
        case .fontModifier:
            return FontModifier.self
        case .foregroundColorModifier:
            return ForegroundColorModifier.self
        case .frameModifier:
            return FrameModifier.self
        case .navigationTitleModifier:
            return NavigationTitleModifier.self
        case .paddingModifier:
            return PaddingModifier.self
        case .tapGestureModifier:
            return TapGestureModifier.self
        case .unknown:
            return nil
        }
    }
}
