import JXBridge
import JXKit
@testable import JXSwiftUI
import SwiftUI
import XCTest

final class FontTests: JXSwiftUITestsBase {
    func testNamed() throws {
        let _ = try context.eval("swiftui.Font.custom('name', 12)")
        expectingError {
            let _ = try context.eval("swiftui.Font.custom('name')")
        }
        expectingError {
            let _ = try context.eval("swiftui.Font.custom('name', {})")
        }
    }
    
    func testNamedFixed() throws {
        let _ = try context.eval("swiftui.Font.custom('name', {fixedSize: 10})")
    }
    
    func testNamedRelative() throws {
        let _ = try context.eval("swiftui.Font.custom('name', {size: 2, style: 'body'})")
        let _ = try context.eval("swiftui.Font.custom('name', {style: 'body'})")
    }
    
    func testSystem() throws {
        let _ = try context.eval("swiftui.Font.system(12)").convey(to: Font.self)
    }
    
    func testSystemStyle() throws {
        let _ = try context.eval("swiftui.Font.system('body')").convey(to: Font.self)
    }
    
    func testSystemSpec() throws {
        if #available(iOS 16.0, *) {
            let _ = try context.eval("swiftui.Font.system({size: 12, weight: 'bold', design: 'monospaced'})").convey(to: Font.self)
            expectingError {
                let _ = try context.eval("swiftui.Font.system({size: 12, weight: 'bold', design: 'invalid'})").convey(to: Font.self)
            }
        }
#if !os(macOS)
        if #available(iOS 16.0, *) {
            let _ = try context.eval("swiftui.Font.system({style: 'body', weight: 'bold', design: 'monospaced'})").convey(to: Font.self)
            expectingError {
                let _ = try context.eval("swiftui.Font.system({style: 'body', weight: 'bold', design: 'invalid'})").convey(to: Font.self)
            }
        }
#endif
    }
    
    func testSystemDefined() throws {
        let _ = try context.eval("swiftui.Font.title").convey(to: Font.self)
        let _ = try context.eval("swiftui.Font.body").convey(to: Font.self)
    }
    
    func testFunctions() throws {
        let _ = try context.eval("swiftui.Font.title.bold()").convey(to: Font.self)
        let _ = try context.eval("swiftui.Font.body.monospacedDigit()").convey(to: Font.self)
    }
}
