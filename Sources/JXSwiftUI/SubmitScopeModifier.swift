import SwiftUI

extension JXSwiftUISupport {
    /// Prevents submission of the target view from triggering `onSubmit` actions higher up the view hierarchy.
    ///
    /// Supported calls:
    ///
    ///     - .submitScope()
    ///     - .submitScope(bool)
    public enum submitScope {}
}

struct SubmitScopeModifier: BoolModifier {
    static let type = ElementType.submitScopeModifier

    let target: Content
    let value: Bool

    func apply(to view: any View, errorHandler: ErrorHandler) -> any View {
        return view.submitScope(value)
    }
}
