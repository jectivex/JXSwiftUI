import JXBridge
import JXKit
import SwiftUI

extension JXSwiftUISupport {
    /// A `SwiftUI.Image` value.
    ///
    /// Supported usage:
    ///
    ///     - Image.named('name', {props}) to load from an asset catalog
    ///     - Image.system('name') to load SF Symbols
    ///     - Image.system('name', {props})
    ///
    /// Supported `props`:
    ///
    ///     - variableValue: A number between 0.0 and 1.0 that the rendered image may use to customize its appearance
    ///     - label: SwiftUI uses this value for accessibility. Required for images loaded from an asset catalog
    ///
    /// Supported functions:
    ///
    ///     - .resizable(): Derive a resizable image
    ///     - .resizable({props}): Derive a resizable image with the following props:
    ///             - capInsets: EdgeInsets
    ///             - resizingMode: Image.ResizingMode
    public enum Image {}

    /// Use a JavaScript string to name any standard `SwiftUI.Image.ResizingMode` value, e.g. `'stretch'`.
    public enum ResizingMode {}
}

extension Image: JXStaticBridging {
    static public func jxBridge() throws -> JXBridge {
        JXBridgeBuilder(type: Image.self)
            .asJXSwiftUIView()

            // Use static funcs to replace Image constructors to hide the use of 'new', which is
            // incongruous with our other SwiftUI elements

            .static.func.named { (name: String, props: JXValue) throws -> Image in
                let labelValue = try props["label"]
                guard labelValue.isString else {
                    throw JXError(message: "'Image.named' requires a 'label' string in props")
                }
                let label = try Text(labelValue.string)
                let variableValueValue = try props["variableValue"]
                let variableValue = try variableValueValue.isNullOrUndefined ? nil : variableValueValue.double
#if os(macOS) // Couldn't get the #available check to compile on Mac
                guard variableValue == nil else {
                    throw JXError(message: "'variableValue' is only supported in iOS 16+")
                }
                return Image(name, label: label)
#else
                if #available(iOS 16.0, *) {
                    return Image(name, variableValue: variableValue, label: label)
                } else {
                    guard variableValue == nil else {
                        throw JXError(message: "'variableValue' is only supported in iOS 16+ / macOS 13+")
                    }
                    return Image(name, label: label)
                }
#endif
            }
            .static.func.system { (name: String) -> Image in
                return Image(systemName: name)
            }
            .static.func.system { (name: String, props: JXValue) throws -> Image in
                let labelValue = try props["label"]
                guard labelValue.isUndefined else {
                    throw JXError(message: "'Image.system' does not support 'label'")
                }
                let variableValueValue = try props["variableValue"]
                let variableValue = try variableValueValue.isNullOrUndefined ? nil : variableValueValue.double
#if os(macOS) // Couldn't get the #available check to compile on Mac
                guard variableValue == nil else {
                    throw JXError(message: "'variableValue' is only supported in iOS 16+ / macOS 13+")
                }
                return Image(systemName: name)
#else
                if #available(iOS 16.0, *) {
                    return Image(systemName: name, variableValue: variableValue)
                } else {
                    guard variableValue == nil else {
                        throw JXError(message: "'variableValue' is only supported in iOS 16+")
                    }
                    return Image(systemName: name)
                }
#endif
            }
            .func.resizable { $0.resizable() }
            .func.resizable { (image: Image, props: JXValue) throws in
                let capInsetsValue = try props["capInsets"]
                let capInsets = try capInsetsValue.isNullOrUndefined ? EdgeInsets() : capInsetsValue.convey(to: EdgeInsets.self)
                let resizingModeValue = try props["resizingMode"]
                let resizingMode = try resizingModeValue.isNullOrUndefined ? Image.ResizingMode.stretch : resizingModeValue.convey(to: Image.ResizingMode.self)
                return image.resizable(capInsets: capInsets, resizingMode: resizingMode)
            }
            .bridge
    }
}

extension Image.ResizingMode: RawRepresentable {
    public init?(rawValue: String) {
        switch rawValue {
        case "stretch":
            self = .stretch
        case "tile":
            self = .tile
        default:
            return nil
        }
    }

    public var rawValue: String {
        switch self {
        case .stretch:
            return "stretch"
        case .tile:
            return "tile"
        @unknown default:
            return "unknown"
        }
    }
}
