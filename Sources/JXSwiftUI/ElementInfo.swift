import SwiftUI

typealias ErrorHandler = (Error) -> Void

/// Information from the script's representation of a UI element.
protocol ElementInfo {
    var elementType: ElementType { get }
    func view(errorHandler: ErrorHandler?) -> TypeSwitchView
}

extension ElementInfo {
    func view(errorHandler: ErrorHandler?) -> TypeSwitchView {
        return TypeSwitchView(info: self, errorHandler: errorHandler)
    }
}

extension Array where Element == ElementInfo {
    @ViewBuilder
    func containerView(errorHandler: ErrorHandler?) -> some View {
        // NOTE: ForEach caused a blank view followed by a crash after minutes
        // of no activity, so fallback to brute force
        switch self.count {
        case 0:
            Group {
            }
        case 1:
            self[0].view(errorHandler: errorHandler)
        case 2:
            Group {
                self[0].view(errorHandler: errorHandler)
                self[1].view(errorHandler: errorHandler)
            }
        case 3:
            Group {
                self[0].view(errorHandler: errorHandler)
                self[1].view(errorHandler: errorHandler)
                self[2].view(errorHandler: errorHandler)
            }
        case 4:
            Group {
                self[0].view(errorHandler: errorHandler)
                self[1].view(errorHandler: errorHandler)
                self[2].view(errorHandler: errorHandler)
                self[3].view(errorHandler: errorHandler)
            }
        case 5:
            Group {
                self[0].view(errorHandler: errorHandler)
                self[1].view(errorHandler: errorHandler)
                self[2].view(errorHandler: errorHandler)
                self[3].view(errorHandler: errorHandler)
                self[4].view(errorHandler: errorHandler)
            }
        case 6:
            Group {
                self[0].view(errorHandler: errorHandler)
                self[1].view(errorHandler: errorHandler)
                self[2].view(errorHandler: errorHandler)
                self[3].view(errorHandler: errorHandler)
                self[4].view(errorHandler: errorHandler)
                self[5].view(errorHandler: errorHandler)
            }
        case 7:
            Group {
                self[0].view(errorHandler: errorHandler)
                self[1].view(errorHandler: errorHandler)
                self[2].view(errorHandler: errorHandler)
                self[3].view(errorHandler: errorHandler)
                self[4].view(errorHandler: errorHandler)
                self[5].view(errorHandler: errorHandler)
                self[6].view(errorHandler: errorHandler)
            }
        case 8:
            Group {
                self[0].view(errorHandler: errorHandler)
                self[1].view(errorHandler: errorHandler)
                self[2].view(errorHandler: errorHandler)
                self[3].view(errorHandler: errorHandler)
                self[4].view(errorHandler: errorHandler)
                self[5].view(errorHandler: errorHandler)
                self[6].view(errorHandler: errorHandler)
                self[7].view(errorHandler: errorHandler)
            }
        case 9:
            Group {
                self[0].view(errorHandler: errorHandler)
                self[1].view(errorHandler: errorHandler)
                self[2].view(errorHandler: errorHandler)
                self[3].view(errorHandler: errorHandler)
                self[4].view(errorHandler: errorHandler)
                self[5].view(errorHandler: errorHandler)
                self[6].view(errorHandler: errorHandler)
                self[7].view(errorHandler: errorHandler)
                self[8].view(errorHandler: errorHandler)
            }
        case 10:
            Group {
                self[0].view(errorHandler: errorHandler)
                self[1].view(errorHandler: errorHandler)
                self[2].view(errorHandler: errorHandler)
                self[3].view(errorHandler: errorHandler)
                self[4].view(errorHandler: errorHandler)
                self[5].view(errorHandler: errorHandler)
                self[6].view(errorHandler: errorHandler)
                self[7].view(errorHandler: errorHandler)
                self[8].view(errorHandler: errorHandler)
                self[9].view(errorHandler: errorHandler)
            }
        default:
            EmptyView()
        }
    }
}

