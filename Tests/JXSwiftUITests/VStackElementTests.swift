import JXBridge
import JXKit
@testable import JXSwiftUI
import XCTest

final class VStackElementTests: JXSwiftUITestsBase {
    func testNoProps() throws {
        let jxValue = try context.eval("jxswiftui.VStack([jxswiftui.EmptyView()])")
        let stack = try VStackElement(jxValue: jxValue)
        let _ = stack.view(errorHandler: errorHandler)
    }
    
    func testBadContent() throws {
        expectingError {
            let jxValue = try context.eval("jxswiftui.VStack()")
            let stack = try VStackElement(jxValue: jxValue)
            let _ = stack.view(errorHandler: errorHandler)
        }
        expectingError {
            let jxValue = try context.eval("jxswiftui.VStack(jxswiftui.EmptyView())")
            let stack = try VStackElement(jxValue: jxValue)
            let _ = stack.view(errorHandler: errorHandler)
        }
    }
    
    func testProps() throws {
        var jxValue = try context.eval("jxswiftui.VStack({}, [])")
        var stack = try VStackElement(jxValue: jxValue)
        let _ = stack.view(errorHandler: errorHandler)
        
        jxValue = try context.eval("jxswiftui.VStack({alignment: 'leading', spacing: 10}, [])")
        stack = try VStackElement(jxValue: jxValue)
        let _ = stack.view(errorHandler: errorHandler)
        
        expectingError {
            jxValue = try context.eval("jxswiftui.VStack({alignment: 'invalid', spacing: 10}, [])")
            stack = try VStackElement(jxValue: jxValue)
            let _ = stack.view(errorHandler: errorHandler)
        }
    }
}
