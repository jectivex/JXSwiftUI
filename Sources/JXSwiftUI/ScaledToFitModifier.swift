import SwiftUI

extension JXSwiftUISupport {
    /// Scales a target view to fit.
    ///
    /// Supported calls:
    ///
    ///     - .scaledToFit()
    public enum scaledToFit {}
}

struct ScaledToFitModifier: EmptyModifier {
    static let type = ElementType.scaledToFitModifier
    let target: Content

    func apply(to view: any View, errorHandler: ErrorHandler) -> any View {
        return view.scaledToFit()
    }
}
