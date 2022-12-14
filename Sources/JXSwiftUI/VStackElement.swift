import JXBridge
import JXKit
import SwiftUI

extension JXSwiftUISupport {
    /// A `SwiftUI.VStack`.
    ///
    /// Supported usage:
    ///
    ///     - VStack([content])
    ///     - VStack({props}, [content])
    ///
    /// Supported `props`:
    ///
    ///     - alignment: HorizontalAlignment
    ///     - spacing
    ///
    /// Supported `content`:
    ///
    ///     - View array
    ///     - Anonymous function returning a View array
    public enum VStack {}
}

struct VStackElement: Element {
    private let alignment: HorizontalAlignment
    private let spacing: CGFloat?
    private let content: Content
    
    init(jxValue: JXValue) throws {
        let alignmentValue = try jxValue["alignment"]
        self.alignment = try alignmentValue.isUndefined ? .center : alignmentValue.convey()
        let spacingValue = try jxValue["spacing"]
        self.spacing = try spacingValue.isUndefined ? nil : spacingValue.convey()
        self.content = try Content(jxValue: jxValue["content"])
    }

    func view(errorHandler: ErrorHandler) -> any View {
        return VStack(alignment: alignment, spacing: spacing) {
            let errorHandler = errorHandler.in(.vstack)
            content.elementArray(errorHandler: errorHandler)
                .containerView(errorHandler: errorHandler)
        }
    }
    
    static func js(namespace: JXNamespace) -> String? {
        """
function(propsOrContentArray, contentArray) {
    const e = new \(JSCodeGenerator.elementClass)('\(ElementType.vstack.rawValue)');
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
