import JXBridge
import JXKit
import SwiftUI

extension JXSwiftUISupport {
    /// A `SwiftUI.Button`.
    ///
    /// Supported usage:
    ///
    ///     - Button('label', () => { action })
    ///     - Button(() => { action }, content)
    ///     - Button({props}, () => { action })
    ///     - Button({props}, () => { action }, content)
    ///
    /// Supported `props`:
    ///
    ///     - label: content
    ///     - role: ButtonRole
    ///
    /// Supported `content`:
    ///
    ///     - Label string
    ///     - View
    ///     - Anonymous function returning a View
    public enum Button {}
    
    /// Use a JavaScript string to name any standard `SwiftUI.ButtonRole` value, e.g. `'cancel'`.
    public enum ButtonRole {}
}

struct ButtonElement: Element {
    private let role: ButtonRole?
    private let actionFunction: JXValue
    private let content: Content

    init(jxValue: JXValue) throws {
        let args = try jxValue["args"].array
        guard args.count >= 2 else {
            throw JXError(message: "An action function and a label or content are required")
        }
        if args[0].isString {
            self.role = nil
            self.content = try Content(jxValue: args[0])
            self.actionFunction = args[1]
        } else if args[0].isFunction {
            self.role = nil
            self.actionFunction = args[0]
            self.content = try Content(jxValue: args[1])
        } else {
            let roleValue = try args[0]["role"]
            self.role = try roleValue.isUndefined ? nil : roleValue.convey()
            self.actionFunction = args[1]
            if args.count < 3 {
                let labelValue = try args[0]["label"]
                guard !labelValue.isUndefined else {
                    throw JXError.missingContent()
                }
                self.content = try Content(jxValue: labelValue)
            } else {
                self.content = try Content(jxValue: args[2])
            }
        }
    }

    func view(errorHandler: ErrorHandler?) -> any View {
        let errorHandler = errorHandler?.in(.button)
        return Button(role: role, action: {
            onAction(errorHandler: errorHandler)
        }) {
            content.element(errorHandler: errorHandler)
                .view(errorHandler: errorHandler)
                .eraseToAnyView()
        }
    }
    
    static func js(namespace: JXNamespace) -> String? {
"""
function(...args) {
    const e = new \(JXNamespace.default).\(JSCodeGenerator.elementClass)('\(ElementType.button.rawValue)');
    e.args = args;
    return e;
}
"""
    }
    
    private func onAction(errorHandler: ErrorHandler?) {
        do {
            try actionFunction.call()
        } catch {
            errorHandler?.attr("action").handle(error)
        }
    }
}

extension ButtonRole: RawRepresentable {
    public init?(rawValue: String) {
        switch rawValue {
        case "cancel":
            self = .cancel
        case "destructive":
            self = .destructive
        default:
            return nil
        }
    }
    
    public var rawValue: String {
        switch self {
        case .cancel:
            return "cancel"
        case .destructive:
            return "destructive"
        default:
            return "unknown"
        }
    }
}
