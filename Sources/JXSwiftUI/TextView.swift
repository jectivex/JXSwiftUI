import JXKit
import SwiftUI

/// A view whose body is a `SwiftUI.Text` view.
struct TextView: View {
    let info: TextInfo
    let errorHandler: ErrorHandler?

    var body: some View {
        Text(info.text)
    }
}

struct TextInfo: ElementInfo {
    init(jxValue: JXValue) throws {
        self.text = try jxValue["text"].string
    }

    init(text: String) {
        self.text = text
    }

    var elementType: ElementType {
        return .text
    }

    let text: String
}
