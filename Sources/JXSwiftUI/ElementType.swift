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
    case picker = "Picker"
    case scrollView = "ScrollView"
    case section = "Section"
    case secureField = "SecureField"
    case slider = "Slider"
    case spacer = "Spacer"
    case text = "Text"
    case textEditor = "TextEditor"
    case textField = "TextField"
    case toggle = "Toggle"
    case vstack = "VStack"
    case zstack = "ZStack"
    case unknown

    // Modifiers
#if !os(macOS)
    case autocorrectionDisabledModifier = "autocorrectionDisabled"
#endif
    case backgroundModifier = "background"
    case borderModifier = "border"
    case fontModifier = "font"
    case foregroundColorModifier = "foregroundColor"
    case frameModifier = "frame"
#if !os(macOS)
    case keyboardTypeModifier = "keyboardType"
#endif
    case listStyleModifier = "listStyle"
    case navigationTitleModifier = "navigationTitle"
    case paddingModifier = "padding"
    case pickerStyleModifier = "pickerStyle"
    case submitModifier = "onSubmit"
    case submitScopeModifier = "submitScope"
    case tagModifier = "tag"
    case tapGestureModifier = "onTapGesture"
    case textContentTypeModifier = "textContentType"
    case textFieldStyleModifier = "textFieldStyle"
#if !os(macOS)
    case textInputAutocapitalizationModifier = "textInputAutocapitalization"
#endif
    
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
        case .picker:
            return PickerElement.self
        case .scrollView:
            return ScrollViewElement.self
        case .section:
            return SectionElement.self
        case .secureField:
            return SecureFieldElement.self
        case .slider:
            return SliderElement.self
        case .spacer:
            return SpacerElement.self
        case .text:
            return TextElement.self
        case .textEditor:
            return TextEditorElement.self
        case .textField:
            return TextFieldElement.self
        case .toggle:
            return ToggleElement.self
        case .vstack:
            return VStackElement.self
        case .zstack:
            return ZStackElement.self

#if !os(macOS)
        case .autocorrectionDisabledModifier:
            return AutocorrectionDisabledModifier.self
#endif
        case .backgroundModifier:
            return BackgroundModifier.self
        case .borderModifier:
            return BorderModifier.self
        case .fontModifier:
            return FontModifier.self
        case .foregroundColorModifier:
            return ForegroundColorModifier.self
        case .frameModifier:
            return FrameModifier.self
#if !os(macOS)
        case .keyboardTypeModifier:
            return KeyboardTypeModifier.self
#endif
        case .listStyleModifier:
            return ListStyleModifier.self
        case .navigationTitleModifier:
            return NavigationTitleModifier.self
        case .paddingModifier:
            return PaddingModifier.self
        case .pickerStyleModifier:
            return PickerStyleModifier.self
        case .submitModifier:
            return SubmitModifier.self
        case .submitScopeModifier:
            return SubmitScopeModifier.self
        case .tagModifier:
            return TagModifier.self
        case .tapGestureModifier:
            return TapGestureModifier.self
        case .textContentTypeModifier:
            return TextContentTypeModifier.self
        case .textFieldStyleModifier:
            return TextFieldStyleModifier.self
#if !os(macOS)
        case .textInputAutocapitalizationModifier:
            return TextInputAutocapitalizationModifier.self
#endif

        case .unknown:
            return nil
        }
    }
}
