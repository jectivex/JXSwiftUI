import JXBridge
import JXKit
import SwiftUI

extension JXSwiftUISupport {
    /// Sets the corner radius on a target view.
    ///
    /// Supported calls:
    ///
    ///     - .cornerRadius(number)
    public enum cornerRadius {}
}

struct CornerRadiusModifier: SingleValueModifier {
    static let type = ElementType.cornerRadiusModifier
    let target: Content
    let value: CGFloat

    static func convert(_ value: JXValue) throws -> CGFloat {
        return try value.double
    }

    func apply(to view: any View, errorHandler: ErrorHandler) -> any View {
        return view.cornerRadius(value)
    }
}
