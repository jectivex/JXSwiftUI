/// All supported UI element types.
///
/// - Note: Raw values are equal to JS function names.
enum ElementType: String, CaseIterable {
    // Views
    case button = "Button"
    case custom
    case empty = "Empty"
    case foreach = "ForEach"
    case hstack = "HStack"
    case `if` = "If"
    case list = "List"
    case navigationLink = "NavigationLink"
    case navigationView = "NavigationView"
    case spacer = "Spacer"
    case text = "Text"
    case vstack = "VStack"
    case unknown

    // Modifiers
    case fontModifier = "FontModifier"
    case navigationTitleModifier = "NavigationTitleModifier"
    case tapGestureModifier = "TapGestureModifier"
}
