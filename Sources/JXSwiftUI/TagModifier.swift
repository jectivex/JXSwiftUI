import JXBridge
import JXKit
import SwiftUI

extension JXSwiftUISupport {
    /// Tags a target view.
    ///
    /// Supported calls:
    ///
    ///     - .tag(value)
    ///
    /// The `value` should be a JavaScript boolean, number, string, date, or bridged `Hashable` object.
    ///
    /// - Seealso: `Picker`
    public enum tag {}
}

struct TagModifier: SingleValueModifier {
    static let type = ElementType.tagModifier
    let target: Content
    let value: HashableValue

    static func convert(_ value: JXValue) throws -> HashableValue {
        return try value.convey()
    }
    
    func apply(to view: any View, errorHandler: ErrorHandler) -> any View {
        switch value {
        case .bool(let value):
            return view.tag(value)
        case .date(let value):
            return view.tag(value)
        case .double(let value):
            return view.tag(value)
        case .string(let value):
            return view.tag(value)
        case .hashable(let value):
            return view.tag(value)
        }
    }
}
