import JXBridge
import JXKit
@testable import JXSwiftUI
import XCTest

final class FontModifierTests: JXSwiftUITestsBase {
    func testFontStyle() throws {
        var jxValue = try context.eval("jxswiftui.EmptyView().font('title2')")
        let font = try FontModifier(jxValue: jxValue)
        let _ = font.view(errorHandler: errorHandler)
        
        expectingError {
            jxValue = try context.eval("jxswiftui.EmptyView().font('invalid')")
            let font = try FontModifier(jxValue: jxValue)
            let _ = font.view(errorHandler: errorHandler)
        }
        expectingError {
            jxValue = try context.eval("jxswiftui.EmptyView().font(2)")
            let font = try FontModifier(jxValue: jxValue)
            let _ = font.view(errorHandler: errorHandler)
        }
        expectingError {
            jxValue = try context.eval("jxswiftui.EmptyView().font()")
            let font = try FontModifier(jxValue: jxValue)
            let _ = font.view(errorHandler: errorHandler)
        }
    }
    
    func testFont() throws {
        var jxValue = try context.eval("jxswiftui.EmptyView().font(jxswiftui.Font.system(12))")
        var font = try FontModifier(jxValue: jxValue)
        let _ = font.view(errorHandler: errorHandler)
        
        jxValue = try context.eval("jxswiftui.EmptyView().font(jxswiftui.Font.system(12).bold())")
        font = try FontModifier(jxValue: jxValue)
        let _ = font.view(errorHandler: errorHandler)
    }
}
