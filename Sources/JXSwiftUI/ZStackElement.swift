import JXBridge
import JXKit
import SwiftUI

extension JXSwiftUISupport {
    /// A `SwiftUI.ZStack`.
    /// Supported usage:
    ///
    ///     - ZStack([content])
    ///     - ZStack({props}, [content])
    ///
    /// Supported props:
    ///
    ///     - alignment: Alignment
    ///
    /// Supported content:
    ///
    ///     - View array
    ///     - Anonymous function returning a View array
    public enum ZStack {}
}

struct ZStackElement: Element {
    private let alignment: Alignment
    private let content: Content
    
    init(jxValue: JXValue) throws {
        let alignmentValue = try jxValue["alignment"]
        self.alignment = try alignmentValue.isUndefined ? .center : alignmentValue.convey()
        self.content = try Content(jxValue: jxValue["content"])
    }

    func view(errorHandler: ErrorHandler?) -> any View {
        return ZStack(alignment: alignment) {
            let errorHandler = errorHandler?.in(.zstack)
            content.elementArray(errorHandler: errorHandler)
                .containerView(errorHandler: errorHandler)
        }
    }
    
    static func js(namespace: JXNamespace) -> String? {
        """
function(propsOrContentArray, contentArray) {
    const e = new \(JXNamespace.default).\(JSCodeGenerator.elementClass)('\(ElementType.zstack.rawValue)');
    if (contentArray === undefined) {
        e.content = propsOrContentArray;
    } else {
        e.alignment = propsOrContentArray.alignment;
        e.content = contentArray;
    }
    return e;
}
"""
    }
}

