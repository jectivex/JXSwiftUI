import SwiftUI

extension JXSwiftUISupport {
    /// Scales a target view to fill.
    ///
    /// Supported calls:
    ///
    ///     - .scaledToFill()
    public enum scaledToFill {}
}

struct ScaledToFillModifier: EmptyModifier {
    static let type = ElementType.scaledToFillModifier
    let target: Content

    func apply(to view: any View, errorHandler: ErrorHandler) -> any View {
        return view.scaledToFill()
    }
}
