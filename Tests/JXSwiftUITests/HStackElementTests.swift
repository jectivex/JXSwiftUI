import JXBridge
import JXKit
@testable import JXSwiftUI
import XCTest

final class HStackElementTests: JXSwiftUITestsBase {
    func testNoProps() throws {
        let jxValue = try context.eval("swiftui.HStack([swiftui.EmptyView()])")
        let stack = try HStackElement(jxValue: jxValue)
        let _ = stack.view(errorHandler: errorHandler)
    }
    
    func testBadContent() throws {
        expectingError {
            let jxValue = try context.eval("swiftui.HStack()")
            let stack = try HStackElement(jxValue: jxValue)
            let _ = stack.view(errorHandler: errorHandler)
        }
        expectingError {
            let jxValue = try context.eval("swiftui.HStack(swiftui.EmptyView())")
            let stack = try HStackElement(jxValue: jxValue)
            let _ = stack.view(errorHandler: errorHandler)
        }
    }
    
    func testProps() throws {
        var jxValue = try context.eval("swiftui.HStack({}, [])")
        var stack = try HStackElement(jxValue: jxValue)
        let _ = stack.view(errorHandler: errorHandler)
        
        jxValue = try context.eval("swiftui.HStack({alignment: 'top', spacing: 10}, [])")
        stack = try HStackElement(jxValue: jxValue)
        let _ = stack.view(errorHandler: errorHandler)
        
        expectingError {
            jxValue = try context.eval("swiftui.HStack({alignment: 'invalid', spacing: 10}, [])")
            stack = try HStackElement(jxValue: jxValue)
            let _ = stack.view(errorHandler: errorHandler)
        }
    }
}
