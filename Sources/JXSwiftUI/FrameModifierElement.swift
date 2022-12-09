import JXBridge
import JXKit
import SwiftUI

/// Sets a frame on its target view.
struct FrameModifierElement: Element {
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

    func view(errorHandler: ErrorHandler?) -> any View {
        let targetView = target.element(errorHandler: errorHandler)
            .view(errorHandler: errorHandler)
        if minWidth != nil || idealWidth != nil || maxWidth != nil || minHeight != nil || idealHeight != nil || maxHeight != nil {
            return targetView.frame(minWidth: minWidth, idealWidth: idealWidth, maxWidth: maxWidth, minHeight: minHeight, idealHeight: idealHeight, maxHeight: maxHeight, alignment: alignment ?? .center)
        } else {
            return targetView.frame(width: width, height: height, alignment: alignment ?? .center)
        }
    }
    
    static func modifierJS(namespace: JXNamespace) -> String? {
        // .frame(width, height, alignment) or .frame({ minWidth:, ... }), alignment)
        return """
function(widthOrParams, heightOrAlignment, alignment) {
    const e = new \(namespace).JXElement('\(ElementType.frameModifier.rawValue)');
    e.target = this;
    if (typeof(widthOrParams) === 'number') {
        e.width = widthOrParams;
        e.height = heightOrAlignment;
        e.alignment = (alignment === undefined) ? null : alignment;
        e.minWidth = null;
        e.idealWidth = null;
        e.maxWidth = null;
        e.minHeight = null;
        e.idealHeight = null;
        e.maxHeight = null;
    } else {
        e.width = null;
        e.height = null;
        e.alignment = (heightOrAlignment === undefined) ? null : heightOrAlignment;
        e.minWidth = (widthOrParams.minWidth === undefined) ? null : widthOrParams.minWidth;
        e.idealWidth = (widthOrParams.idealWidth === undefined) ? null : widthOrParams.idealWidth;
        e.maxWidth = (widthOrParams.maxWidth === undefined) ? null : widthOrParams.maxWidth;
        e.minHeight = (widthOrParams.minHeight === undefined) ? null : widthOrParams.minHeight;
        e.idealHeight = (widthOrParams.idealHeight === undefined) ? null : widthOrParams.idealHeight;
        e.maxHeight = (widthOrParams.maxHeight === undefined) ? null : widthOrParams.maxHeight;
    }
    return e;
}
"""
    }
}
