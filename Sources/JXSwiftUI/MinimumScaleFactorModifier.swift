import JXBridge
import JXKit
import SwiftUI

extension JXSwiftUISupport {
    /// Sets a minimum scale factor on a target view.
    ///
    /// Supported calls:
    ///
    ///     - .minimumScaleFactor(number)
    public enum minimumScaleFactor {}
}

struct MinimumScaleFactorModifier: SingleValueModifier {
    static let type = ElementType.minimumScaleFactorModifier
    let target: Content
    let value: CGFloat

    static func convert(_ value: JXValue) throws -> CGFloat {
        return try value.double
    }

    func apply(to view: any View, errorHandler: ErrorHandler) -> any View {
        return view.minimumScaleFactor(value)
    }
}
