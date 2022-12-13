import JXBridge
import JXKit
import SwiftUI

extension JXSwiftUISupport {
    /// Sets a frame on a target view.
    ///
    /// Supported calls:
    ///
    ///     - .frame(with, height)
    ///     - .frame(width, height, alignment)
    ///     - .frame({props})
    ///
    /// Supported `props`:
    ///
    ///     - width
    ///     - height
    ///     - alignment: Alignment
    ///
    /// Or:
    /// 
    ///     - minWidth
    ///     - idealWidth
    ///     - maxWidth
    ///     - minHeight
    ///     - idealHeight
    ///     - maxHeight
    ///     - alignment: Alignment
    public enum frame {}
}

struct FrameModifier: Element {
    private let target: Content
    private let width: CGFloat?
    private let height: CGFloat?
    private let minWidth: CGFloat?
    private let idealWidth: CGFloat?
    private let maxWidth: CGFloat?
    private let minHeight: CGFloat?
    private let idealHeight: CGFloat?
    private let maxHeight: CGFloat?
    private let alignment: Alignment?
    
    init(jxValue: JXValue) throws {
        self.target = try Content(jxValue: jxValue["target"])
        self.width = try jxValue["width"].convey()
        self.height = try jxValue["height"].convey()
        self.minWidth = try jxValue["minWidth"].convey()
        self.idealWidth = try jxValue["idealWidth"].convey()
        self.maxWidth = try jxValue["maxWidth"].convey()
        self.minHeight = try jxValue["minHeight"].convey()
        self.idealHeight = try jxValue["idealHeight"].convey()
        self.maxHeight = try jxValue["maxHeight"].convey()
        self.alignment = try jxValue["alignment"].convey()
    }

    func view(errorHandler: ErrorHandler) -> any View {
        let targetView = target.element(errorHandler: errorHandler)
            .view(errorHandler: errorHandler)
        if minWidth != nil || idealWidth != nil || maxWidth != nil || minHeight != nil || idealHeight != nil || maxHeight != nil {
            return targetView.frame(minWidth: minWidth, idealWidth: idealWidth, maxWidth: maxWidth, minHeight: minHeight, idealHeight: idealHeight, maxHeight: maxHeight, alignment: alignment ?? .center)
        } else {
            return targetView.frame(width: width, height: height, alignment: alignment ?? .center)
        }
    }
    
    static func modifierJS(namespace: JXNamespace) -> String? {
        return """
function(widthOrProps, height, alignment) {
    const e = new \(JXNamespace.default).\(JSCodeGenerator.elementClass)('\(ElementType.frameModifier.rawValue)');
    e.target = this;
    if (typeof(widthOrProps) === 'number') {
        e.width = widthOrProps;
        e.height = (height === undefined) ? null : height;
        e.alignment = (alignment === undefined) ? null : alignment;
        e.minWidth = null;
        e.idealWidth = null;
        e.maxWidth = null;
        e.minHeight = null;
        e.idealHeight = null;
        e.maxHeight = null;
    } else {
        const props = widthOrProps;
        e.width = (props.width === undefined) ? null : props.width;
        e.height = (props.height === undefined) ? null : props.height;
        e.alignment = (props.alignment === undefined) ? null : props.alignment;
        e.minWidth = (props.minWidth === undefined) ? null : props.minWidth;
        e.idealWidth = (props.idealWidth === undefined) ? null : props.idealWidth;
        e.maxWidth = (props.maxWidth === undefined) ? null : props.maxWidth;
        e.minHeight = (props.minHeight === undefined) ? null : props.minHeight;
        e.idealHeight = (props.idealHeight === undefined) ? null : props.idealHeight;
        e.maxHeight = (props.maxHeight === undefined) ? null : props.maxHeight;
    }
    return e;
}
"""
    }
}
