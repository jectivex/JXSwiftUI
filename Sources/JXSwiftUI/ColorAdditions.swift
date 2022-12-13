import JXBridge
import JXKit
import SwiftUI

extension JXSwiftUISupport {
    /// A `SwiftUI.Color` value.
    ///
    /// Supported usage:
    ///
    ///     - Color.red, Color.blue, etc
    ///     - Color.system({props})
    ///     - Color.custom('name') to load from an asset catalog
    ///
    /// Supported `props`:
    ///
    ///     - opacity: Optional opacity
    ///     - red:green:blue: RGB color
    ///     - hue:saturation:brightness: HSB color
    ///     - white: Grayscale color
    ///
    /// Supported functions:
    ///
    ///     - .opacity(value): Derive a color with the given opacity
    public enum Color {}
}

extension Color: JXStaticBridging {
    static public func jxBridge() throws -> JXBridge {
        JXBridgeBuilder(type: Color.self)
            .asJXSwiftUIView()
        
            // Use static funcs to replace Color constructors to align with Font and
            // hide the use of 'new', which is incongruous with our other SwiftUI elements
        
            .static.func.system { (props: JXValue) throws -> Color in
                let opacityValue = try props["opacity"]
                let opacity = try opacityValue.isUndefined ? 1.0 : opacityValue.double
                let redValue = try props["red"]
                guard redValue.isUndefined else {
                    let greenValue = try props["green"]
                    let blueValue = try props["blue"]
                    guard !greenValue.isUndefined && !blueValue.isUndefined else {
                        throw JXError(message: "Expected number values for 'red', 'green', 'blue'")
                    }
                    return try Color(red: redValue.double, green: greenValue.double, blue: blueValue.double, opacity: opacity)
                }

                let whiteValue = try props["white"]
                guard whiteValue.isUndefined else {
                    return try Color(white: whiteValue.double, opacity: opacity)
                }
                
                let hueValue = try props["hue"]
                let saturationValue = try props["saturation"]
                let brightnessValue = try props["brightness"]
                guard !hueValue.isUndefined && !saturationValue.isUndefined && !brightnessValue.isUndefined else {
                    throw JXError(message: "Expected number values for 'red', 'green', 'blue' or 'hue', 'saturation', 'brightness'")
                }
                return try Color(hue: hueValue.double, saturation: saturationValue.double, brightness: brightnessValue.double, opacity: opacity)
            }
            .static.func.custom { (name: String) -> Color in Color(name) }
            .func.opacity { Color.opacity }
            .static.var.black { Color.black }
            .static.var.blue { Color.blue }
            .static.var.brown { Color.brown }
            .static.var.clear { Color.clear }
            .static.var.cyan { Color.cyan }
            .static.var.gray { Color.gray }
            .static.var.green { Color.green }
            .static.var.indigo { Color.indigo }
            .static.var.mint { Color.mint }
            .static.var.orange { Color.orange }
            .static.var.pink { Color.pink }
            .static.var.purple { Color.purple }
            .static.var.red { Color.red }
            .static.var.teal { Color.teal }
            .static.var.white { Color.white }
            .static.var.yellow { Color.yellow }
            .static.var.accentColor { Color.accentColor }
            .static.var.primary { Color.primary }
            .static.var.secondary { Color.secondary }
            .bridge
    }
}
