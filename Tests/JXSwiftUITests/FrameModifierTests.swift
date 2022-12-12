import JXBridge
import JXKit
@testable import JXSwiftUI
import XCTest

final class FrameModifierTests: JXSwiftUITestsBase {
    func testWidthHeightAlignment() throws {
        var jxValue = try context.eval("swiftui.EmptyView().frame(10, 10)")
        var frame = try FrameModifier(jxValue: jxValue)
        let _ = frame.view(errorHandler: errorHandler)
        
        jxValue = try context.eval("swiftui.EmptyView().frame(10, 10, 'topLeading')")
        frame = try FrameModifier(jxValue: jxValue)
        let _ = frame.view(errorHandler: errorHandler)
        
        expectingError {
            jxValue = try context.eval("swiftui.EmptyView().frame(10, 10, 'invalid')")
            frame = try FrameModifier(jxValue: jxValue)
            let _ = frame.view(errorHandler: errorHandler)
        }
    }
    
    func testWidthHeightAlignmentProps() throws {
        var jxValue = try context.eval("swiftui.EmptyView().frame({width: 10, height: 10})")
        var frame = try FrameModifier(jxValue: jxValue)
        let _ = frame.view(errorHandler: errorHandler)
        
        jxValue = try context.eval("swiftui.EmptyView().frame({width: 10, height: 10, alignment: 'topLeading'})")
        frame = try FrameModifier(jxValue: jxValue)
        let _ = frame.view(errorHandler: errorHandler)
        
        expectingError {
            jxValue = try context.eval("swiftui.EmptyView().frame({width: 10, heihgt: 10, alignment: 'invalid')")
            frame = try FrameModifier(jxValue: jxValue)
            let _ = frame.view(errorHandler: errorHandler)
        }
    }
    
    func testMinMaxIdealProps() throws {
        var jxValue = try context.eval("swiftui.EmptyView().frame({minWidth: 10, maxWidth: Infinity, idealHeight: 20, alignment: 'bottomTrailing'})")
        var frame = try FrameModifier(jxValue: jxValue)
        let _ = frame.view(errorHandler: errorHandler)
        
        expectingError {
            jxValue = try context.eval("swiftui.EmptyView().frame({minWidth: 10, maxWidth: Infinity, idealHeight: 20, alignment: 'invalid'})")
            frame = try FrameModifier(jxValue: jxValue)
            let _ = frame.view(errorHandler: errorHandler)
        }
    }
}
