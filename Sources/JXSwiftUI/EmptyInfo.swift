import SwiftUI

/// Vends an empty view.
struct EmptyInfo: ElementInfo {
    var elementType: ElementType {
        return .empty
    }
    
    @ViewBuilder
    func view(errorHandler: ErrorHandler?) -> any View {
        EmptyView()
    }
}
