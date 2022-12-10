import JXBridge
import JXKit
import SwiftUI

extension JXSupported {
    /// A `SwiftUI.Button`.
    /// Supported usage:
    ///
    ///     - Button('label', () => { action })
    ///     - Button(() => { action }, content)
    ///     - Button({props}, () => { action }, content)
    ///
    /// Supported props:
    ///
    ///     - label: String. If included, the label is considered the button content.
    ///     - role: ButtonRole
    ///
    /// Supported content:
    ///
    ///     - View
    ///     - Anonymous function returning a View
    public struct Button {}
    
    /// Use a JavaScript string to name any standard `SwiftUI.ButtonRole` value, e.g. `'cancel'`.
    public struct ButtonRole {}
}

struct ButtonElement: Element {
    private let role: ButtonRole?
    private let actionFunction: JXValue
    private let content: Content

    init(jxValue: JXValue) throws {
        self.role = try jxValue["role"].convey()
        self.actionFunction = try jxValue["action"]
        guard actionFunction.isFunction else {
            throw JXError(message: "Expected an action function. Received '\(actionFunction)'")
        }
        self.content = try Content(jxValue: jxValue["content"])
    }

    func view(errorHandler: ErrorHandler?) -> any View {
        let errorHandler = errorHandler?.in(.button)
        return Button(action: {
            onAction(errorHandler: errorHandler)
        }) {
            content.element(errorHandler: errorHandler)
                .view(errorHandler: errorHandler)
                .eraseToAnyView()
        }
    }
    
    static func js(namespace: JXNamespace) -> String? {
"""
function(propsOrActionOrLabel, actionOrContent, content) {
    const e = new \(JXNamespace.default).\(JSCodeGenerator.elementClass)('\(ElementType.button.rawValue)');
    if (typeof(propsOrActionOrLabel) === 'string') {
        e.action = actionOrContent;
        e.content = \(namespace).Text(actionOrLabel);
    } else if typeof(propsOrActionOrLabel) === 'function') {
        e.role = null;
        e.action = propsOrActionOrLabel;
        e.content = actionOrContent;
    } else {
        e.role = (propsOrActionOrLabel.role === undefined) ? null : propsOrActionOrLabel.role;
        if (content === undefined) {
            e.content = Text(
        } else {
            e.content = content;
        }
    }
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
