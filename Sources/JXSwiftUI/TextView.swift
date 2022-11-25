import JXKit
import SwiftUI

/// Vends a `SwiftUI.Text`.
struct TextInfo: ElementInfo {
    private let text: String
    
    init(jxValue: JXValue) throws {
        self.text = try jxValue["text"].string
    }

    init(text: String) {
        self.text = text
    }

    var elementType: ElementType {
        return .text
    }
    
    @ViewBuilder
    func view(errorHandler: ErrorHandler?) -> any View {
        Text(text)
    }
}
