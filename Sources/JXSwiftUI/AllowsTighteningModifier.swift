import SwiftUI

extension JXSwiftUISupport {
    /// Allow tightening on a target view.
    ///
    /// Supported calls:
    ///
    ///     - .allowsTightening()
    ///     - .allowsTightening(bool)
    public enum allowsTightening {}
}

struct AllowsTighteningModifier: BoolModifier {
    static let type = ElementType.allowsTighteningModifier

    let target: Content
    let value: Bool

    func apply(to view: any View, errorHandler: ErrorHandler) -> any View {
        return view.allowsTightening(value)
    }
}
