import JXBridge
import JXKit
@testable import JXSwiftUI
import XCTest

final class TextElementTests: JXSwiftUITestsBase {
    func testText() throws {
        let jxValue = try context.eval("swiftui.Text('text')")
        let button = try TextElement(jxValue: jxValue)
        let _ = button.view(errorHandler: errorHandler)
    }

    func testVerbatim() throws {
        let jxValue = try context.eval("swiftui.Text({verbatim: true}, 'text')")
        let button = try TextElement(jxValue: jxValue)
        let _ = button.view(errorHandler: errorHandler)
    }
    
    func testFunctions() throws {
        let jxValue = try context.eval("swiftui.Text('text').bold().italic(true)")
        let button = try TextElement(jxValue: jxValue)
        let _ = button.view(errorHandler: errorHandler)
    }
}
