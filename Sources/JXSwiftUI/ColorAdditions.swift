import JXBridge
import SwiftUI

extension Color: JXStaticBridging {
    static public func jxBridge() throws -> JXBridge {
        JXBridgeBuilder(type: Color.self)
            .constructor { Color.init(_:) }
            .constructor { (r: Double, g: Double, b: Double) in Color(red: r, green: g, blue: b) }
            .constructor { (r: Double, g: Double, b: Double, o: Double) in Color(red: r, green: g, blue: b, opacity: o) }
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
