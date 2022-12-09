import JXBridge
import JXKit
import SwiftUI

extension Font: JXStaticBridging {
    static public func jxBridge() throws -> JXBridge {
        JXBridgeBuilder(type: Font.self)
            // Font.system(size) or Font.system('style') or Font.system({props}) where props can be size,design,weight
            // or style,design,weight
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
                    guard sizeValue.isUndefined else {
                        return try Font.system(size: sizeValue.double, weight: weight, design: design)
                    }
                    let styleValue = try props["style"]
                    return try Font.system(styleValue.convey(to: Font.TextStyle.self), design: design, weight: weight)
                } else {
                    return try Font.system(props.convey(to: Font.TextStyle.self))
                }
            }
            // Font.custom('name', size) or Font.custom('name', {props}) where props can be fixedSize or size,relativeTo
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
                let relativeToValue = try props["relativeTo"]
                guard relativeToValue.isUndefined else {
                    let relativeTo = try relativeToValue.convey(to: Font.TextStyle.self)
                    return try Font.custom(name, size: sizeValue.double, relativeTo: relativeTo)
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
