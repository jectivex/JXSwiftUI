#if !os(macOS)
import SwiftUI

extension JXSwiftUISupport {
    /// Disables autocorrection on a target view.
    ///
    /// Supported calls:
    ///
    ///     - .autocorrectionDisabled()
    ///     - .autocorrectionDisabled(bool)
    public enum autocorrectionDisabled {}
}

struct AutocorrectionDisabledModifier: BoolModifier {
    static let type = ElementType.autocorrectionDisabledModifier

    let target: Content
    let value: Bool

    func apply(to view: any View, errorHandler: ErrorHandler) -> any View {
        return view.autocorrectionDisabled(value)
    }
}
#endif
