import JXBridge
import JXKit
@testable import JXSwiftUI
import XCTest

final class VStackElementTests: JXSwiftUITestsBase {
    func testNoProps() throws {
        let jxValue = try context.eval("swiftui.VStack([swiftui.EmptyView()])")
        let stack = try VStackElement(jxValue: jxValue)
        let _ = stack.view(errorHandler: errorHandler)
    }
    
    func testBadContent() throws {
        expectingError {
            let jxValue = try context.eval("swiftui.VStack()")
            let stack = try VStackElement(jxValue: jxValue)
            let _ = stack.view(errorHandler: errorHandler)
        }
        expectingError {
            let jxValue = try context.eval("swiftui.VStack(swiftui.EmptyView())")
            let stack = try VStackElement(jxValue: jxValue)
            let _ = stack.view(errorHandler: errorHandler)
        }
    }
    
    func testProps() throws {
        var jxValue = try context.eval("swiftui.VStack({}, [])")
        var stack = try VStackElement(jxValue: jxValue)
        let _ = stack.view(errorHandler: errorHandler)
        
        jxValue = try context.eval("swiftui.VStack({alignment: 'leading', spacing: 10}, [])")
        stack = try VStackElement(jxValue: jxValue)
        let _ = stack.view(errorHandler: errorHandler)
        
        expectingError {
            jxValue = try context.eval("swiftui.VStack({alignment: 'invalid', spacing: 10}, [])")
            stack = try VStackElement(jxValue: jxValue)
            let _ = stack.view(errorHandler: errorHandler)
        }
    }
}
