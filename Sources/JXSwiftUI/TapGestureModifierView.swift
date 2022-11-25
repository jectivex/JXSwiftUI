import JXKit
import SwiftUI

/// Adds a tap gesture to its target view.
struct TapGestureModifierInfo: ElementInfo {
    private let targetInfo: ElementInfo
    private let onTapFunction: JXValue

    init(jxValue: JXValue) throws {
        self.targetInfo = try Self.info(for: jxValue["target"], in: .tapGestureModifier)
        self.onTapFunction = try jxValue["action"]
        guard self.onTapFunction.isFunction else {
            throw JXSwiftUIErrors.valueNotFunction(elementType.rawValue, "action")
        }
    }

    var elementType: ElementType {
        return .tapGestureModifier
    }

    @ViewBuilder
    func view(errorHandler: ErrorHandler?) -> any View {
        AnyView(targetInfo.view(errorHandler: errorHandler))
            .onTapGesture {
                onTapGesture(errorHandler: errorHandler)
            }
    }

    func onTapGesture(errorHandler: ErrorHandler?) {
        do {
            try onTapFunction.call(withArguments: [])
        } catch {
            errorHandler?(error)
        }
    }
}
