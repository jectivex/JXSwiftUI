import SwiftUI

protocol SpacerInfo: ElementInfo {
}

/// A view whose body is a `SwiftUI.Spacer` view.
struct SpacerView: View {
    let info: SpacerInfo
    let errorHandler: ErrorHandler?

    var body: some View {
        Spacer()
    }
}
