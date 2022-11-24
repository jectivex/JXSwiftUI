import SwiftUI

protocol TapGestureModifierInfo: ElementInfo {
    var targetInfo: ElementInfo { get throws }
    func onTapGesture() throws
}

/// A view that adds a tap gesture to its target view.
struct TapGestureModifierView: View {
    let info: TapGestureModifierInfo
    let errorHandler: ErrorHandler?

    var body: some View {
        targetInfo.view(errorHandler: errorHandler)
            .onTapGesture {
                onTapGesture()
            }
    }

    private var targetInfo: ElementInfo {
        do {
            return try info.targetInfo
        } catch {
            errorHandler?(error)
            return EmptyInfo()
        }
    }

    private func onTapGesture() {
        do {
            try info.onTapGesture()
        } catch {
            errorHandler?(error)
        }
    }
}
