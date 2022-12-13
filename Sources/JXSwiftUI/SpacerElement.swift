import JXBridge
import JXKit
import SwiftUI

extension JXSwiftUISupport {
    /// A `SwiftUI.Spacer`.
    /// 
    /// Supported usage:
    ///
    ///     - Spacer()
    ///     - Spacer(minLength)
    public enum Spacer {}
}

struct SpacerElement: Element {
    let minLength: CGFloat?
    
    init(jxValue: JXValue) throws {
        let minLengthValue = try jxValue["minLength"]
        self.minLength = try minLengthValue.isNullOrUndefined ? nil : minLengthValue.double
    }

    func view(errorHandler: ErrorHandler) -> any View {
        return Spacer(minLength: minLength)
    }
    
    static func js(namespace: JXNamespace) -> String? {
        """
function(minLength) {
    const e = new \(JXNamespace.default).\(JSCodeGenerator.elementClass)('\(ElementType.spacer.rawValue)');
    e.minLength = minLength;
    return e;
}
"""
    }
}
