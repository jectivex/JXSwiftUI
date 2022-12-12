import JXBridge
import JXKit
import SwiftUI

extension JXSwiftUISupport {
    /// A `SwiftUI.If` conditional view.
    /// Supported usage:
    ///
    ///     - If(boolean, () => { content })
    ///     - If(boolean, () => { content }, () => { content })
    ///
    /// In the form with two trailing functions, the second provides `else` content.
    /// Supported content:
    ///
    ///     - Anonymous function returning a View
    public enum If {}
}

struct IfElement: Element {
    private let isTrue: Bool
    private let ifContent: Content
    private let elseContent: Content?

    init(jxValue: JXValue) throws {
        self.isTrue = try jxValue["isTrue"].bool
        self.ifContent = try Content(jxValue: jxValue["ifFunction"])
        self.elseContent = try Content.optional(jxValue: jxValue["elseContent"])
    }

    func view(errorHandler: ErrorHandler?) -> any View {
        let errorHandler = errorHandler?.in(.if)
        if isTrue {
            return ifContent.element(errorHandler: errorHandler)
                .view(errorHandler: errorHandler)
        }
        if let elseContent {
            let errorHandler = errorHandler?.attr("else")
            return elseContent.element(errorHandler: errorHandler)
                .view(errorHandler: errorHandler)
        }
        return EmptyView()
    }
    
    static func js(namespace: JXNamespace) -> String? {
        """
function(isTrue, ifFunction, elseFunction) {
    const e = new \(JXNamespace.default).\(JSCodeGenerator.elementClass)('\(ElementType.if.rawValue)');
    e.isTrue = isTrue;
    e.ifFunction = ifFunction;
    e.elseFunction = elseFunction;
    return e;
}
"""
    }
}
