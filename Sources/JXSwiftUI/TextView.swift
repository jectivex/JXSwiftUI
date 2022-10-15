import SwiftUI

protocol TextInfo: ElementInfo {
    var text: String { get throws }
}

/// A view whose body is a `SwiftUI.Text` view.
struct TextView: View {
    private let info: TextInfo

    init(_ info: TextInfo) {
        self.info = info
    }

    var body: some View {
        Text(text)
    }

    private var text: String {
        do {
            return try info.text
        } catch {
            // TODO: Error handler
            return ""
        }
    }
}
