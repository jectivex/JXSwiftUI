import JXBridge
import JXKit
import SwiftUI

extension JXSupported {
    /// Sets a background on a target view.
    /// Supported calls:
    ///
    ///     - .background({props}, content)
    ///     - .background(content)
    ///
    /// Supported props:
    ///
    ///     - alignment: Alignment
    ///
    /// Supported content:
    ///
    ///     - Color name
    ///     - View
    ///     - Anonymous function returning a View
    public struct BackgroundModifier {}
}

struct BackgroundModifier: Element {
    private let target: Content
    private let alignment: Alignment
    private let content: Content
    
    init(jxValue: JXValue) throws {
        self.target = try Content(jxValue: jxValue["target"])
        let args = try jxValue["args"].array
        guard !args.isEmpty else {
            throw JXError.missingContent()
        }
        if args.count == 1 {
            self.alignment = .center
            if args[0].isString {
                self.content = try Content(view: Color(args[0].string))
            } else {
                self.content = Content(jxValue: args[0])
            }
        } else {
            self.alignment = try args[0].convey()
            if args[1].isString {
                self.content = try Content(view: Color(args[1].string))
            } else {
                self.content = Content(jxValue: args[1])
            }
        }
    }

    func view(errorHandler: ErrorHandler?) -> any View {
        let backgroundErrorHandler = errorHandler?.in(.backgroundModifier)
        return target.element(errorHandler: errorHandler)
            .view(errorHandler: errorHandler)
            .background(alignment: alignment) {
                content.element(errorHandler: backgroundErrorHandler)
                    .view(errorHandler: backgroundErrorHandler)
                    .eraseToAnyView()
            }
    }
    
    static func modifierJS(namespace: JXNamespace) -> String? {
        return """
function(...args) {
    const e = new \(JXNamespace.default).\(JSCodeGenerator.elementClass)('\(ElementType.backgroundModifier.rawValue)');
    e.target = this;
    e.args = arg;
    return e;
}
"""
    }
}
