import SwiftUI

protocol TapGestureModifierInfo: ElementInfo {
    var targetInfo: ElementInfo { get throws }
    func onTapGesture() throws
}

/// A view that adds a tap gesture to its target view.
struct TapGestureModifierView: View {
    private let info: TapGestureModifierInfo

    init(_ info: TapGestureModifierInfo) {
        self.info = info
    }

    var body: some View {
        targetInfo.view
            .onTapGesture {
                onTapGesture()
            }
    }

    private var targetInfo: ElementInfo {
        do {
            return try info.targetInfo
        } catch {
            // TODO: Error handling
            return EmptyInfo()
        }
    }

    private func onTapGesture() {
        do {
            try info.onTapGesture()
        } catch {
            // TODO: Error handling
        }
    }
}
