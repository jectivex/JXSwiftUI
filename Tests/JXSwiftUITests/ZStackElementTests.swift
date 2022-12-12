import JXBridge
import JXKit
@testable import JXSwiftUI
import XCTest

final class ZStackElementTests: JXSwiftUITestsBase {
    func testNoProps() throws {
        let jxValue = try context.eval("swiftui.ZStack([swiftui.EmptyView()])")
        let stack = try ZStackElement(jxValue: jxValue)
        let _ = stack.view(errorHandler: errorHandler)
    }
    
    func testBadContent() throws {
        expectingError {
            let jxValue = try context.eval("swiftui.ZStack()")
            let stack = try ZStackElement(jxValue: jxValue)
            let _ = stack.view(errorHandler: errorHandler)
        }
        expectingError {
            let jxValue = try context.eval("swiftui.ZStack(swiftui.EmptyView())")
            let stack = try ZStackElement(jxValue: jxValue)
            let _ = stack.view(errorHandler: errorHandler)
        }
    }
    
    func testProps() throws {
        var jxValue = try context.eval("swiftui.ZStack({}, [])")
        var stack = try ZStackElement(jxValue: jxValue)
        let _ = stack.view(errorHandler: errorHandler)
        
        jxValue = try context.eval("swiftui.ZStack({alignment: 'topLeading'}, [])")
        stack = try ZStackElement(jxValue: jxValue)
        let _ = stack.view(errorHandler: errorHandler)
        
        expectingError {
            jxValue = try context.eval("swiftui.ZStack({alignment: 'invalid'}, [])")
            stack = try ZStackElement(jxValue: jxValue)
            let _ = stack.view(errorHandler: errorHandler)
        }
    }
}
