import JXBridge
import JXKit
import SwiftUI

extension JXSwiftUISupport {
    /// A `SwiftUI.HStack`.
    ///
    /// Supported usage:
    ///
    ///     - HStack([content])
    ///     - HStack({props}, [content])
    ///
    /// Supported `props`:
    ///
    ///     - alignment: VerticalAlignment
    ///     - spacing
    ///
    /// Supported `content`:
    ///
    ///     - View array
    ///     - Anonymous function returning a View array
    public enum HStack {}
}

struct HStackElement: Element {
    private let alignment: VerticalAlignment
    private let spacing: CGFloat?
    private let content: Content
    
    init(jxValue: JXValue) throws {
        let alignmentValue = try jxValue["alignment"]
        self.alignment = try alignmentValue.isUndefined ? .center : alignmentValue.convey()
        let spacingValue = try jxValue["spacing"]
        self.spacing = try spacingValue.isUndefined ? nil : spacingValue.convey()
        self.content = try Content(jxValue: jxValue["content"])
    }

    func view(errorHandler: ErrorHandler?) -> any View {
        return HStack(alignment: alignment, spacing: spacing) {
            let errorHandler = errorHandler?.in(.hstack)
            content.elementArray(errorHandler: errorHandler)
                .containerView(errorHandler: errorHandler)
        }
    }
    
    static func js(namespace: JXNamespace) -> String? {
        """
function(propsOrContentArray, contentArray) {
    const e = new \(JXNamespace.default).\(JSCodeGenerator.elementClass)('\(ElementType.hstack.rawValue)');
    if (contentArray === undefined) {
        e.content = propsOrContentArray;
    } else {
        e.alignment = propsOrContentArray.alignment;
        e.spacing = propsOrContentArray.spacing;
        e.content = contentArray;
    }
    return e;
}
"""
    }
}
