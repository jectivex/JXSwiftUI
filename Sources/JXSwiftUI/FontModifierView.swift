import SwiftUI

protocol FontModifierInfo: ElementInfo {
    var targetInfo: ElementInfo { get throws }
    var font: Font { get throws }
}

/// A view that specifies a font for its target view.
struct FontModifierView: View {
    let info: FontModifierInfo
    let errorHandler: ErrorHandler?

    var body: some View {
        targetInfo.view(errorHandler: errorHandler)
            .font(font)
    }

    private var targetInfo: ElementInfo {
        do {
            return try info.targetInfo
        } catch {
            errorHandler?(error)
            return EmptyInfo()
        }
    }

    private var font: Font {
        do {
            return try info.font
        } catch {
            errorHandler?(error)
            return .body
        }
    }
}
