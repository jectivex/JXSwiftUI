import JXBridge
import JXKit
import SwiftUI

extension JXSwiftUISupport {
    /// Sets padding on a target view.
    /// 
    /// Supported calls:
    ///
    ///     - .padding()
    ///     - .padding(number)
    ///     - .padding([Edge.Set])
    ///     - .padding([Edge.Set], number)
    ///     - .padding(EdgeInsets)
    public enum padding {}
}

struct PaddingModifier: Element {
    private let target: Content
    private let padding: (any View) -> any View
    
    init(jxValue: JXValue) throws {
        self.target = try Content(jxValue: jxValue["target"])
        let args = try jxValue["args"].array
        if args.isEmpty {
            self.padding = { $0.padding() }
        } else if args[0].isNumber {
            let amount = try args[0].double
            self.padding = { $0.padding(amount) }
        } else if args[0].isArray || args[0].isString {
            let edgesSet = try args[0].convey(to: Edge.Set.self)
            if args.count > 1 {
                let amount = try args[1].double
                self.padding = { $0.padding(edgesSet, amount) }
            } else {
                self.padding = { $0.padding(edgesSet) }
            }
        } else {
            let edgeInsets = try args[0].convey(to: EdgeInsets.self)
            self.padding = { $0.padding(edgeInsets) }
        }
    }
    
    func view(errorHandler: ErrorHandler) -> any View {
        return padding(target.element(errorHandler: errorHandler)
            .view(errorHandler: errorHandler))
    }
    
    static func modifierJS(namespace: JXNamespace) -> String? {
        return """
function(...args) {
    const e = new \(JSCodeGenerator.elementClass)('\(ElementType.paddingModifier.rawValue)');
    e.target = this;
    e.args = args;
    return e;
}
"""
    }
}
