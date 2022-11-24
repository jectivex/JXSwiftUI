import SwiftUI

protocol TextInfo: ElementInfo {
    var text: String { get throws }
}

/// A view whose body is a `SwiftUI.Text` view.
struct TextView: View {
    let info: TextInfo
    let errorHandler: ErrorHandler?

    var body: some View {
        Text(text)
    }

    private var text: String {
        do {
            return try info.text
        } catch {
            errorHandler?(error)
            return ""
        }
    }
}
