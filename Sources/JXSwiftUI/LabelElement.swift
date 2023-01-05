import JXBridge
import JXKit
import SwiftUI

extension JXSwiftUISupport {
    /// A `SwiftUI.Label`.
    ///
    /// Supported usage:
    ///
    ///     - Label({props})
    ///     - Label('label', {props})
    ///     - Label({props}, content)
    ///
    /// Supported `props`:
    ///
    ///     - label: String or content
    ///     - systemImage: SF Symbol image name
    ///     - image: Image or image resource name
    ///     - icon: Content
    public enum Label {}
}

struct LabelElement: Element {
    private let label: Content
    private let icon: Content

    init(jxValue: JXValue) throws {
        self.label = try Content(jxValue: jxValue["label"])

        let propsValue = try jxValue["props"]
        guard !propsValue.isUndefined else {
            throw JXError.missingContent(for: "image")
        }
        let systemImageValue = try propsValue["systemImage"]
        if !systemImageValue.isUndefined {
            self.icon = try Content(view: Image(systemName: systemImageValue.string))
        } else {
            let imageValue = try propsValue["image"]
            if imageValue.isString {
                self.icon = try Content(view: Image(imageValue.string))
            } else if !imageValue.isUndefined {
                self.icon = try Content(view: imageValue.convey(to: Image.self))
            } else {
                let iconValue = try propsValue["icon"]
                guard !iconValue.isUndefined else {
                    throw JXError.missingContent(for: "image")
                }
                self.icon = try Content(jxValue: iconValue)
            }
        }
    }

    func view(errorHandler: ErrorHandler) -> any View {
        let errorHandler = errorHandler.in(.label)
        return Label {
            label.element(errorHandler: errorHandler)
                .view(errorHandler: errorHandler)
                .eraseToAnyView()
        } icon: {
            let iconErrorHandler = errorHandler.attr("icon")
            icon.element(errorHandler: iconErrorHandler)
                .view(errorHandler: iconErrorHandler)
                .eraseToAnyView()
        }
    }

    static func js(namespace: JXNamespace) -> String? {
        """
function(labelOrProps, propsOrContent, content) {
    const e = new \(JSCodeGenerator.elementClass)('\(ElementType.label.rawValue)');
    if (typeof(labelOrProps) === 'string') {
        e.label = labelOrProps;
        e.props = propsOrContent;
    } else if (propsOrContent === undefined) {
        e.label = labelOrProps.label;
        e.props = labelOrProps;
    } else {
        e.label = propsOrContent;
        e.props = labelOrProps;
    }
    return e;
}
"""
    }
}
