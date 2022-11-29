import JXBridge
import JXKit
import SwiftUI

/// A view that includes 'if' or 'else' content depending on a boolean condition.
struct IfInfo: ElementInfo {
    private let isTrue: Bool
    private let ifFunction: JXValue
    private let elseFunction: JXValue

    init(jxValue: JXValue) throws {
        self.isTrue = try jxValue["isTrue"].bool
        self.ifFunction = try jxValue["ifFunction"]
        self.elseFunction = try jxValue["elseFunction"]
        guard ifFunction.isFunction else {
            throw JXSwiftUIErrors.valueNotFunction(elementType.rawValue, "ifFunction")
        }
        guard elseFunction.isNullOrUndefined || self.elseFunction.isFunction else {
            throw JXSwiftUIErrors.valueNotFunction(elementType.rawValue, "elseFunction")
        }
    }

    var elementType: ElementType {
        return .if
    }
    
    func view(errorHandler: ErrorHandler?) -> any View {
        if isTrue {
            return ifContentInfo(errorHandler: errorHandler).view(errorHandler: errorHandler)
        }
        if let elseInfo = elseContentInfo(errorHandler: errorHandler) {
            return elseInfo.view(errorHandler: errorHandler)
        }
        return Group {}
    }
    
    private func ifContentInfo(errorHandler: ErrorHandler?) -> ElementInfo {
        do {
            let ifContent = try ifFunction.call(withArguments: [])
            return try Self.info(for: ifContent, in: elementType)
        } catch {
            errorHandler?(error)
            return EmptyInfo()
        }
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

    private func elseContentInfo(errorHandler: ErrorHandler?) -> ElementInfo? {
        guard !elseFunction.isNullOrUndefined else {
            return nil
        }
        do {
            let elseContent = try elseFunction.call(withArguments: [])
            return try Self.info(for: elseContent, in: elementType)
        } catch {
            errorHandler?(error)
            return nil
        }
    }
}
