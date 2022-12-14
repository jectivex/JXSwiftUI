import JXBridge
import JXKit
@testable import JXSwiftUI
import SwiftUI
import XCTest

final class ColorTests: JXSwiftUITestsBase {
    func testNamed() throws {
        let _ = try context.eval("jxswiftui.Color.custom('name')")
    }
    
    func testRGB() throws {
        let _ = try context.eval("jxswiftui.Color.system({red: 1.0, green: 0.5, blue: 0.5})").convey(to: Color.self)
        let _ = try context.eval("jxswiftui.Color.system({red: 1.0, green: 0.5, blue: 0.5, opacity: 0.5})").convey(to: Color.self)
    }
    
    func testHSB() throws {
        let _ = try context.eval("jxswiftui.Color.system({hue: 1.0, saturation: 0.5, brightness: 0.5})").convey(to: Color.self)
        let _ = try context.eval("jxswiftui.Color.system({hue: 1.0, saturation: 0.5, brightness: 0.5, opacity: 0.5})").convey(to: Color.self)
    }
    
    func testWhite() throws {
        let _ = try context.eval("jxswiftui.Color.system({white: 0.5})").convey(to: Color.self)
        let _ = try context.eval("jxswiftui.Color.system({white: 0.5, opacity: 0.5})").convey(to: Color.self)
    }
    
    func testSystemDefined() throws {
        let _ = try context.eval("jxswiftui.Color.red").convey(to: Color.self)
        let _ = try context.eval("jxswiftui.Color.primary").convey(to: Color.self)
    }
    
    func testOpacityFunc() throws {
        let _ = try context.eval("jxswiftui.Color.system({red: 1.0, green: 0.5, blue: 0.5}).opacity(0.5)").convey(to: Color.self)
    }
    
    func testInvalid() throws {
        expectingError {
            let _ = try context.eval("jxswiftui.Color.system({})").convey(to: Color.self)
        }
        expectingError {
            let _ = try context.eval("const o = {}; jxswiftui.Color.system({red: o.red, blue: o.blue, green: o.green})").convey(to: Color.self)
        }
    }
}
