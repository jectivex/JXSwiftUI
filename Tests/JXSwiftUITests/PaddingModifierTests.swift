import JXBridge
import JXKit
@testable import JXSwiftUI
import XCTest

final class PaddingModifierTests: JXSwiftUITestsBase {
    func testEmptyPadding() throws {
        let jxValue = try context.eval("swiftui.EmptyView().padding()")
        let padding = try PaddingModifier(jxValue: jxValue)
        let _ = padding.view(errorHandler: errorHandler)
    }
    
    func testNumberPadding() throws {
        let jxValue = try context.eval("swiftui.EmptyView().padding(10)")
        let padding = try PaddingModifier(jxValue: jxValue)
        let _ = padding.view(errorHandler: errorHandler)
    }
    
    func testEdgeInsets() throws {
        let jxValue = try context.eval("swiftui.EmptyView().padding({top: 10, bottom: 10, leading: 10, trailing: 10})")
        let padding = try PaddingModifier(jxValue: jxValue)
        let _ = padding.view(errorHandler: errorHandler)
    }
    
    func testEdges() throws {
        var jxValue = try context.eval("swiftui.EmptyView().padding(['leading', 'top'])")
        var padding = try PaddingModifier(jxValue: jxValue)
        let _ = padding.view(errorHandler: errorHandler)
        
        jxValue = try context.eval("swiftui.EmptyView().padding(['leading', 'top'], 10)")
        padding = try PaddingModifier(jxValue: jxValue)
        let _ = padding.view(errorHandler: errorHandler)
    }
}
