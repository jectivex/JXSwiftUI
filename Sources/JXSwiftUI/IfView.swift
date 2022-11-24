import JXKit
import SwiftUI

/// A view that includes 'if' or 'else' content depending on a boolean condition.
struct IfView: View {
    let info: IfInfo
    let errorHandler: ErrorHandler?

    var body: some View {
        if info.isTrue {
            ifContentInfo.view(errorHandler: errorHandler)
        } else if let elseContentInfo = self.elseContentInfo {
            elseContentInfo.view(errorHandler: errorHandler)
        }
    }

    private var ifContentInfo: ElementInfo {
        do {
            return try info.ifContentInfo
        } catch {
            errorHandler?(error)
            return EmptyInfo()
        }
    }

    private var elseContentInfo: ElementInfo? {
        do {
            return try info.elseContentInfo
        } catch {
            errorHandler?(error)
            return nil
        }
    }
}

struct IfInfo: ElementInfo {
    private let ifFunction: JXValue
    private let elseFunction: JXValue

    init(jxValue: JXValue) throws {
        self.isTrue = try jxValue["isTrue"].bool
        self.ifFunction = try jxValue["ifFunction"]
        self.elseFunction = try jxValue["elseFunction"]
    }

    var elementType: ElementType {
        return .if
    }

    let isTrue: Bool

    var ifContentInfo: ElementInfo {
        get throws {
            guard ifFunction.isFunction else {
                throw JXSwiftUIErrors.valueNotFunction(elementType.rawValue, "ifFunction")
            }
            let ifContent = try ifFunction.call(withArguments: [])
            return try Self.info(for: ifContent, in: elementType)
        }
    }

    var elseContentInfo: ElementInfo? {
        get throws {
            guard !elseFunction.isUndefined else {
                return nil
            }
            guard elseFunction.isFunction else {
                throw JXSwiftUIErrors.valueNotFunction(elementType.rawValue, "elseFunction")
            }
            let elseContent = try elseFunction.call(withArguments: [])
            return try Self.info(for: elseContent, in: elementType)
        }
    }
}
