import JXBridge
import JXKit
import SwiftUI

extension JXSwiftUISupport {
    /// A `SwiftUI.Label`.
    ///
    /// Supported usage:
    ///
    ///     - Label({props})
    ///
    /// Supported `props`:
    ///
    ///     - label: String or content. Required
    ///     - systemImage: SF Symbol image name
    ///     - image: Image or image resource name
    ///     - icon: Content
    public enum Label {}
}

struct LabelElement: Element {
    private let label: Content
    private let icon: Content

    init(jxValue: JXValue) throws {
        let propsValue = try jxValue["props"]
        guard !propsValue.isUndefined else {
            throw JXError.missingContent()
        }

        let labelValue = try propsValue["label"]
        self.label = try Content(jxValue: labelValue)

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
                    throw JXError(message: "'systemImage', 'image', or 'icon' prop is required")
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
function(props) {
    const e = new \(JSCodeGenerator.elementClass)('\(ElementType.label.rawValue)');
    e.props = props;
    return e;
}
"""
    }
}
