/// All supported UI element types.
///
/// - Note: Raw values are equal to JS function names.
enum ElementType: String, CaseIterable {
    // Views
    case button = "Button"
    case custom
    case empty = "Empty"
    case foreach = "ForEach"
    case form = "Form"
    case hstack = "HStack"
    case `if` = "If"
    case list = "List"
    case native
    case navigationLink = "NavigationLink"
    case navigationView = "NavigationView"
    case section = "Section"
    case spacer = "Spacer"
    case text = "Text"
    case vstack = "VStack"
    case unknown

    // Modifiers
    case fontModifier = "FontModifier"
    case navigationTitleModifier = "NavigationTitleModifier"
    case tapGestureModifier = "TapGestureModifier"
}
