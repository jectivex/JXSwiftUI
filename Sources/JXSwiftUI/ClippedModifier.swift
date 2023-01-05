import SwiftUI

extension JXSwiftUISupport {
    /// Clips a target view to fit.
    ///
    /// Supported calls:
    ///
    ///     - .clipped()
    public enum clipped {}
}

struct ClippedModifier: EmptyModifier {
    static let type = ElementType.clippedModifier
    let target: Content

    func apply(to view: any View, errorHandler: ErrorHandler) -> any View {
        return view.clipped()
    }
}
