import JXKit
import SwiftUI

/// A view that adds a tap gesture to its target view.
struct TapGestureModifierView: View {
    let info: TapGestureModifierInfo
    let errorHandler: ErrorHandler?

    var body: some View {
        info.targetInfo.view(errorHandler: errorHandler)
            .onTapGesture {
                onTapGesture()
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

struct TapGestureModifierInfo: ElementInfo {
    private let onTapFunction: JXValue

    init(jxValue: JXValue) throws {
        self.targetInfo = try Self.info(for: jxValue["target"], in: .tapGestureModifier)
        self.onTapFunction = try jxValue["action"]
    }

    var elementType: ElementType {
        return .tapGestureModifier
    }

    let targetInfo: ElementInfo

    func onTapGesture() throws {
        guard onTapFunction.isFunction else {
            throw JXSwiftUIErrors.valueNotFunction(elementType.rawValue, "action")
        }
        try onTapFunction.call(withArguments: [])
    }
}
