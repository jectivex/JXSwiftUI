import JXBridge
import JXKit
@testable import JXSwiftUI
import XCTest

final class IfElementTests: JXSwiftUITestsBase {
    func testMissingContent() throws {
        let jxValue = try context.eval("jxswiftui.If(true)")
        expectingError {
            let ifelement = try IfElement(jxValue: jxValue)
            let _ = ifelement.view(errorHandler: errorHandler)
        }
    }
    
    func testIfOnly() throws {
        let jxValue = try context.eval("jxswiftui.If(true, () => { return jxswiftui.EmptyView() })")
        let ifelement = try IfElement(jxValue: jxValue)
        let _ = ifelement.view(errorHandler: errorHandler)
    }
    
    func testIfElse() throws {
        let jxValue = try context.eval("jxswiftui.If(true, () => { return jxswiftui.EmptyView() }, () => { return jxswiftui.EmptyView() })")
        let ifelement = try IfElement(jxValue: jxValue)
        let _ = ifelement.view(errorHandler: errorHandler)
    }
}
