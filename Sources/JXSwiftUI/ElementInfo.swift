import SwiftUI

/// All supported UI element types.
enum ElementType: String {
    // Views
    case button
    case custom
    case empty
    case foreach
    case hstack
    case list
    case `if`
    case spacer
    case text
    case vstack
    case unknown

    // Modifiers
    case fontModifier
    case tapGestureModifier
}

/// Information from the script's representation of a UI element.
protocol ElementInfo {
    var elementType: ElementType { get }
    var view: TypeSwitchView { get }
}

extension ElementInfo {
    var view: TypeSwitchView {
        return TypeSwitchView(self)
    }
}

extension Array where Element == ElementInfo {
    @ViewBuilder
    var containerView: some View {
        // NOTE: ForEach caused a blank view followed by a crash after minutes
        // of no activity, so fallback to brute force
        switch self.count {
        case 0:
            Group {
            }
        case 1:
            self[0].view
        case 2:
            Group  {
                self[0].view
                self[1].view
            }
        case 3:
            Group  {
                self[0].view
                self[1].view
                self[2].view
            }
        case 4:
            Group  {
                self[0].view
                self[1].view
                self[2].view
                self[3].view
            }
        case 5:
            Group  {
                self[0].view
                self[1].view
                self[2].view
                self[3].view
                self[4].view
            }
        case 6:
            Group  {
                self[0].view
                self[1].view
                self[2].view
                self[3].view
                self[4].view
                self[5].view
            }
        case 7:
            Group  {
                self[0].view
                self[1].view
                self[2].view
                self[3].view
                self[4].view
                self[5].view
                self[6].view
            }
        case 8:
            Group  {
                self[0].view
                self[1].view
                self[2].view
                self[3].view
                self[4].view
                self[5].view
                self[6].view
                self[7].view
            }
        case 9:
            Group  {
                self[0].view
                self[1].view
                self[2].view
                self[3].view
                self[4].view
                self[5].view
                self[6].view
                self[7].view
                self[8].view
            }
        case 10:
            Group  {
                self[0].view
                self[1].view
                self[2].view
                self[3].view
                self[4].view
                self[5].view
                self[6].view
                self[7].view
                self[8].view
                self[9].view
            }
        default:
            // TODO: Error handling
            Group {
            }
        }
    }
}

