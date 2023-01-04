import JXBridge
import JXKit
@testable import JXSwiftUI
import SwiftUI
import XCTest

final class ImageTests: JXSwiftUITestsBase {
    func testNamed() throws {
        let _ = try context.eval("jxswiftui.Image.named('name', {label: 'label'})")
#if os(macOS)
        expectingError {
            let _ = try context.eval("jxswiftui.Image.named('name', {label: 'label', variableValue: 0.5})")
        }
#else
        if #available(iOS 16.0, *) {
            let _ = try context.eval("jxswiftui.Image.named('name', {label: 'label', variableValue: 0.5})")
        } else {
            expectingError {
                let _ = try context.eval("jxswiftui.Image.named('name', {label: 'label', variableValue: 0.5})")
            }
        }
#endif
        expectingError {
            let _ = try context.eval("jxswiftui.Image.named('name')") // Missing label
        }
        expectingError {
            let _ = try context.eval("jxswiftui.Image.named('name', {})") // Missing label
        }
    }

    func testSystem() throws {
        let _ = try context.eval("jxswiftui.Image.system('pencil')")
#if os(macOS)
        expectingError {
            let _ = try context.eval("jxswiftui.Image.system('pencil', {variableValue: 0.5})")
        }
#else
        if #available(iOS 16.0, *) {
            let _ = try context.eval("jxswiftui.Image.system('pencil', {variableValue: 0.5})")
        } else {
            expectingError {
                let _ = try context.eval("jxswiftui.Image.system('pencil', {variableValue: 0.5})")
            }
        }
#endif
        expectingError {
            let _ = try context.eval("jxswiftui.Image.system('pencil', {label: 'label})") // Label not supported
        }
    }

    func testResizable() throws {
        let _ = try context.eval("jxswiftui.Image.system('pencil').resizable()").convey(to: Image.self)
        let _ = try context.eval("jxswiftui.Image.system('pencil').resizable({capInsets: {leading: 1.0}, resizingMode: 'tile'})").convey(to: Image.self)
    }
}
