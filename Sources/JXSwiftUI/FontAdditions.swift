import JXBridge
import JXKit
import SwiftUI

extension JXSwiftUISupport {
    /// A `SwiftUI.Font` value.
    /// Supported usage:
    ///
    ///     - Font.body, Font.title, etc
    ///     - Font.system(size)
    ///     - Font.system(FontTextStyle)
    ///     - Font.system({props})
    ///     - Font.custom('font', size)
    ///     - Font.custom('font', {props})
    ///
    /// Supported props for `Font.system`:
    ///
    ///     - size: Font size
    ///     - style: FontTextStyle in place of specifying the size
    ///     - design: FontDesign
    ///     - weight: FontWeight
    ///
    /// Supported props for `Font.custom`:
    ///
    ///     - fixedSize: Fixed font size
    ///     - size: Size relative to the given style. 0 if omitted
    ///     - style: FontTextStyle
    ///
    /// Supported functions:
    ///
    ///     - bold(), weight(Font.Weight): Return a derived font with the given weight
    ///     - italic(), monospaced(), monospacedDigit(), smallCaps(), lowercaseSmallCaps(), uppercaseSmallCaps(): Return a derived font with the given style
    public enum Font {}
        
    /// Use a JavaScript string to name any standard `Font.TextStyle` value, e.g. `'title'`.
    public enum FontTextStyle {}
        
    /// Use a JavaScript string to name any standard `Font.Design` value, e.g. `'monospaced'`.
    public enum FontDesign {}
        
    /// Use a JavaScript string to name any standard `Font.Weight` value, e.g. `'bold'`.
    public enum FontWeight {}
}

extension Font: JXStaticBridging {
    static public func jxBridge() throws -> JXBridge {
        JXBridgeBuilder(type: Font.self)
            .static.func.system { (props: JXValue) throws -> Font in
                guard !props.isNumber else {
                    return try Font.system(size: props.double)
                }
                
                if #available(iOS 16.0, *) {
                    guard !props.isString else {
                        return try Font.system(props.convey(to: Font.TextStyle.self))
                    }
                    
                    let designValue = try props["design"]
                    let design = try designValue.isUndefined ? nil : designValue.convey(to: Font.Design.self)
                    let weightValue = try props["weight"]
                    let weight = try weightValue.isUndefined ? nil : weightValue.convey(to: Font.Weight.self)
                    
                    let sizeValue = try props["size"]
#if os(macOS)
                    guard !sizeValue.isUndefined else {
                        throw JXError(message: "Missing font size")
                    }
                    return try Font.system(size: sizeValue.double, weight: weight ?? .regular, design: design ?? .default)
#else
                    guard sizeValue.isUndefined else {
                        return try Font.system(size: sizeValue.double, weight: weight, design: design)
                    }
                    let styleValue = try props["style"]
                    guard !styleValue.isUndefined else {
                        throw JXError(message: "Invalid font properties")
                    }
                    return try Font.system(styleValue.convey(to: Font.TextStyle.self), design: design, weight: weight)
#endif
                } else {
                    guard !props.isUndefined else {
                        throw JXError(message: "Invalid font properties")
                    }
                    return try Font.system(props.convey(to: Font.TextStyle.self))
                }
            }
            .static.func.custom { (name: JXValue, props: JXValue) throws -> Font in
                let name = try name.string
                guard !props.isNumber else {
                    return try Font.custom(name, size: props.double)
                }
                
                let fixedSizeValue = try props["fixedSize"]
                guard fixedSizeValue.isUndefined else {
                    return try Font.custom(name, fixedSize: fixedSizeValue.double)
                }
                
                let sizeValue = try props["size"]
                let styleValue = try props["style"]
                guard styleValue.isUndefined else {
                    let style = try styleValue.convey(to: Font.TextStyle.self)
                    return try Font.custom(name, size: sizeValue.isUndefined ? 0.0 : sizeValue.double, relativeTo: style)
                }
                guard !sizeValue.isUndefined else {
                    throw JXError(message: "Missing font size")
                }
                return try Font.custom(name, size: sizeValue.double)
            }
            .static.var.largeTitle { Font.largeTitle }
            .static.var.title { Font.title }
            .static.var.title2 { Font.title2 }
            .static.var.title3 { Font.title3 }
            .static.var.headline { Font.headline }
            .static.var.subheadline { Font.subheadline }
            .static.var.body { Font.body }
            .static.var.callout { Font.callout }
            .static.var.caption { Font.caption }
            .static.var.caption2 { Font.caption2 }
            .static.var.footnote { Font.footnote }
            .func.bold { Font.bold }
            .func.italic { Font.italic }
            .func.monospaced { Font.monospaced }
            .func.monospacedDigit { Font.monospacedDigit }
            .func.smallCaps { Font.smallCaps }
            .func.lowercaseSmallCaps { Font.lowercaseSmallCaps }
            .func.uppercaseSmallCaps { Font.uppercaseSmallCaps }
            .func.weight { Font.weight }
            .bridge
    }
}

extension Font.TextStyle: RawRepresentable {
    public init?(rawValue: String) {
        switch rawValue {
        case Self.largeTitle.rawValue:
            self = .largeTitle
        case Self.title.rawValue:
            self = .title
        case Self.title2.rawValue:
            self = .title2
        case Self.title3.rawValue:
            self = .title3
        case Self.headline.rawValue:
            self = .headline
        case Self.subheadline.rawValue:
            self = .subheadline
        case Self.body.rawValue:
            self = .body
        case Self.callout.rawValue:
            self = .callout
        case Self.caption.rawValue:
            self = .caption
        case Self.caption2.rawValue:
            self = .caption2
        case Self.footnote.rawValue:
            self = .footnote
        default:
            return nil
        }
    }
    
    public var rawValue: String {
        switch self {
        case .largeTitle:
            return "largeTitle"
        case .title:
            return "title"
        case .title2:
            return "title2"
        case .title3:
            return "title3"
        case .headline:
            return "headline"
        case .subheadline:
            return "subheadline"
        case .body:
            return "body"
        case .callout:
            return "callout"
        case .caption:
            return "caption"
        case .caption2:
            return "caption2"
        case .footnote:
            return "footnote"
        @unknown default:
            return "unknown"
        }
    }
}

extension Font.Design: RawRepresentable {
    public init?(rawValue: String) {
        switch rawValue {
        case Self.default.rawValue:
            self = .default
        case Self.serif.rawValue:
            self = .serif
        case Self.rounded.rawValue:
            self = .rounded
        case Self.monospaced.rawValue:
            self = .monospaced
        default:
            return nil
        }
    }
    
    public var rawValue: String {
        switch self {
        case .default:
            return "default"
        case .serif:
            return "serif"
        case .rounded:
            return "rounded"
        case .monospaced:
            return "monospaced"
        @unknown default:
            return "unknown"
        }
    }
}

extension Font.Weight: RawRepresentable {
    public init?(rawValue: String) {
        switch rawValue {
        case Self.black.rawValue:
            self = .black
        case Self.bold.rawValue:
            self = .bold
        case Self.heavy.rawValue:
            self = .heavy
        case Self.light.rawValue:
            self = .light
        case Self.medium.rawValue:
            self = .medium
        case Self.regular.rawValue:
            self = .regular
        case Self.semibold.rawValue:
            self = .semibold
        case Self.thin.rawValue:
            self = .thin
        case Self.ultraLight.rawValue:
            self = .ultraLight
        default:
            return nil
        }
    }
    
    public var rawValue: String {
        switch self {
        case .black:
            return "black"
        case .bold:
            return "bold"
        case .heavy:
            return "heavy"
        case .light:
            return "light"
        case .medium:
            return "medium"
        case .regular:
            return "regular"
        case .semibold:
            return "semibold"
        case .thin:
            return "thin"
        case .ultraLight:
            return "ultraLight"
        default:
            return "unknown"
        }
    }
}
