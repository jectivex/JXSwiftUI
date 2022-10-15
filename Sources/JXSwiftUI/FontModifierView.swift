import SwiftUI

protocol FontModifierInfo: ElementInfo {
    var targetInfo: ElementInfo { get throws }
    var font: Font { get throws }
}

/// A view that specifies a font for its target view.
struct FontModifierView: View {
    private let info: FontModifierInfo

    init(_ info: FontModifierInfo) {
        self.info = info
    }

    var body: some View {
        targetInfo.view
            .font(font)
    }

    private var targetInfo: ElementInfo {
        do {
            return try info.targetInfo
        } catch {
            // TODO: Error handling
            return EmptyInfo()
        }
    }

    private var font: Font {
        do {
            return try info.font
        } catch {
            // TODO: Error handling
            return .body
        }
    }
}
