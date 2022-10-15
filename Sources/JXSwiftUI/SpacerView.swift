import SwiftUI

protocol SpacerInfo: ElementInfo {
}

/// A view whose body is a `SwiftUI.Spacer` view.
struct SpacerView: View {
    private let info: SpacerInfo

    init(_ info: SpacerInfo) {
        self.info = info
    }

    var body: some View {
        Spacer()
    }
}
