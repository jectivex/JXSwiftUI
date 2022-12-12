import JXBridge
import JXKit
import SwiftUI

extension JXSwiftUISupport {
    /// A `SwiftUI.ScrollView`.
    /// Supported usage:
    ///
    ///     - ScrollView(content)
    ///     - ScrollView({props}, content)
    ///
    /// Supported props:
    ///
    ///     - axes: [Axis] array
    ///     - showsIndicators: Boolean
    ///
    /// Supported content:
    ///
    ///     - View
    ///     - Anonymous function returning a View
    public enum ScrollView {}
}

struct ScrollViewElement: Element {
    private let showsIndicators: Bool
    private let axesSet: Axis.Set
    private let content: Content
    
    init(jxValue: JXValue) throws {
        let showsIndicatorsValue = try jxValue["showsIndicators"]
        self.showsIndicators = showsIndicatorsValue.isUndefined || showsIndicatorsValue.bool
        let axesValue = try jxValue["axes"]
        if axesValue.isUndefined {
            self.axesSet = .vertical
        } else {
            let axes = try axesValue.array.map { try $0.convey(to: Axis.self) }
            let rawValue = axes.reduce(0) { $0 | $1.rawValue }
            self.axesSet = Axis.Set(rawValue: Int8(rawValue))
        }
        self.content = try Content(jxValue: jxValue["content"])
    }

    func view(errorHandler: ErrorHandler?) -> any View {
        return ScrollView(axesSet, showsIndicators: showsIndicators) {
            let errorHandler = errorHandler?.in(.scrollView)
            content.element(errorHandler: errorHandler)
                .view(errorHandler: errorHandler)
                .eraseToAnyView()
        }
    }
    
    static func js(namespace: JXNamespace) -> String? {
        """
function(propsOrContent, content) {
    const e = new \(JXNamespace.default).\(JSCodeGenerator.elementClass)('\(ElementType.scrollView.rawValue)');
    if (content === undefined) {
        e.content = propsOrContent;
    } else {
        e.showsIndicators = propsOrContent.showsIndicators;
        e.axes = propsOrContent.axes;
        e.content = content;
    }
    return e;
}
"""
    }
}
