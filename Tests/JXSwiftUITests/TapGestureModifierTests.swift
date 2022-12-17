import JXBridge
import JXKit
@testable import JXSwiftUI
import XCTest

final class TapGestureModifierTests: JXSwiftUITestsBase {
    func testValid() throws {
        var jxValue = try context.eval("jxswiftui.EmptyView().onTapGesture(() => {})")
        var tap = try TapGestureModifier(jxValue: jxValue)
        let _ = tap.view(errorHandler: errorHandler)
        
        jxValue = try context.eval("jxswiftui.EmptyView().onTapGesture(2, () => {})")
        tap = try TapGestureModifier(jxValue: jxValue)
        let _ = tap.view(errorHandler: errorHandler)
    }
    
    func testInvalid() throws {
        expectingError {
            let jxValue = try context.eval("jxswiftui.EmptyView().onTapGesture(2)")
            let tap = try TapGestureModifier(jxValue: jxValue)
            let _ = tap.view(errorHandler: errorHandler)
        }
        expectingError {
            let jxValue = try context.eval("jxswiftui.EmptyView().onTapGesture(2, 'string')")
            let tap = try TapGestureModifier(jxValue: jxValue)
            let _ = tap.view(errorHandler: errorHandler)
        }
    }
}
