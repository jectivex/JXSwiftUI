import JXBridge
import JXKit
import SwiftUI

/// A view that includes 'if' or 'else' content depending on a boolean condition.
struct IfElement: Element {
    private let isTrue: Bool
    private let ifContent: Content
    private let elseContent: Content?

    init(jxValue: JXValue) throws {
        self.isTrue = try jxValue["isTrue"].bool
        self.ifContent = try Content(jxValue: jxValue["ifFunction"])
        let elseValue = try jxValue["elseFunction"]
        self.elseContent = elseValue.isNullOrUndefined ? nil : Content(jxValue: elseValue)
    }

    var elementType: ElementType {
        return .if
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
function(isTrue, ifFunction, elseFunction=null) {
    const e = new \(namespace.value).JXElement('\(ElementType.if.rawValue)');
    e.isTrue = isTrue;
    e.ifFunction = ifFunction;
    e.elseFunction = elseFunction;
    return e;
}
"""
    }
}
