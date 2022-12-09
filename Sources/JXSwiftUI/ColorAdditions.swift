import JXBridge
import JXKit
import SwiftUI

extension Color: JXStaticBridging {
    static public func jxBridge() throws -> JXBridge {
        JXBridgeBuilder(type: Color.self)
            // new Color('name') or new Color({props}) where props can be red,green,blue,opacity
            // or white,opacity or hue,saturation,brightness,opacity
            .constructor { (props: JXValue) throws -> Color in
                guard !props.isString else {
                    return try Color(props.string)
                }
                
                let opacityValue = try props["opacity"]
                let opacity = try opacityValue.isUndefined ? 1.0 : opacityValue.double
                let redValue = try props["red"]
                guard redValue.isUndefined else {
                    let greenValue = try props["green"]
                    let blueValue = try props["blue"]
                    return try Color(red: redValue.double, green: greenValue.double, blue: blueValue.double, opacity: opacity)
                }

                let whiteValue = try props["white"]
                guard whiteValue.isUndefined else {
                    return try Color(white: whiteValue.double, opacity: opacity)
                }
                
                let hueValue = try props["hue"]
                let saturationValue = try props["saturation"]
                let brightnessValue = try props["brightness"]
                return try Color(hue: hueValue.double, saturation: saturationValue.double, brightness: brightnessValue.double, opacity: opacity)
            }
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
