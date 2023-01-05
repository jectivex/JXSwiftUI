import JXKit
import SwiftUI

extension JXSwiftUISupport {
    /// Sets a font weight on a target view.
    ///
    /// Supported calls:
    ///
    ///     - .fontWeight(Font.Weight)
    public enum fontWeight {}
}

struct FontWeightModifier: SingleValueModifier {
    static let type = ElementType.fontWeightModifier
    let target: Content
    let value: Font.Weight

    func apply(to view: any View, errorHandler: ErrorHandler) -> any View {
        if #available(iOS 16.0, *) {
            return view.fontWeight(value)
        } else if let text = view as? Text {
            return text.fontWeight(value)
        } else {
            errorHandler.in(.fontWeightModifier).handle(JXError(message: "'fontWeight' must be called on a 'Text' element before iOS 16"))
            return view
        }
    }
}
