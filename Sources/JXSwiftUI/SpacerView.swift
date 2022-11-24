import JXKit
import SwiftUI

/// A view whose body is a `SwiftUI.Spacer` view.
struct SpacerView: View {
    let info: SpacerInfo
    let errorHandler: ErrorHandler?

    var body: some View {
        Spacer()
    }
}

struct SpacerInfo: ElementInfo {
    init(jxValue: JXValue) throws {
    }

    var elementType: ElementType {
        return .spacer
    }
}
