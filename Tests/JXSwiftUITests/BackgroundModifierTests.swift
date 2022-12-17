import JXBridge
import JXKit
@testable import JXSwiftUI
import XCTest

final class BackgroundModifierTests: JXSwiftUITestsBase {
    func testColorName() throws {
        let jxValue = try context.eval("jxswiftui.EmptyView().background('customColor')")
        let background = try BackgroundModifier(jxValue: jxValue)
        let _ = background.view(errorHandler: errorHandler)
    }
    
    func testView() throws {
        let jxValue = try context.eval("jxswiftui.EmptyView().background(jxswiftui.EmptyView())")
        let background = try BackgroundModifier(jxValue: jxValue)
        let _ = background.view(errorHandler: errorHandler)
    }
    
    func testProps() throws {
        var jxValue = try context.eval("jxswiftui.EmptyView().background({alignment: 'topLeading'}, jxswiftui.EmptyView())")
        let background = try BackgroundModifier(jxValue: jxValue)
        let _ = background.view(errorHandler: errorHandler)
        
        expectingError {
            jxValue = try context.eval("jxswiftui.EmptyView().background({alignment: 'invalid'}, jxswiftui.EmptyView())")
            let _ = try BackgroundModifier(jxValue: jxValue)
        }
    }
}
