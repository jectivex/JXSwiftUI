import JXBridge
import JXKit
@testable import JXSwiftUI
import XCTest

final class BackgroundModifierTests: JXSwiftUITestsBase {
    func testColorName() throws {
        let jxValue = try context.eval("swiftui.EmptyView().background('customColor')")
        let background = try BackgroundModifier(jxValue: jxValue)
        let _ = background.view(errorHandler: errorHandler)
    }
    
    func testView() throws {
        let jxValue = try context.eval("swiftui.EmptyView().background(swiftui.EmptyView())")
        let background = try BackgroundModifier(jxValue: jxValue)
        let _ = background.view(errorHandler: errorHandler)
    }
    
    func testProps() throws {
        var jxValue = try context.eval("swiftui.EmptyView().background({alignment: 'topLeading'}, swiftui.EmptyView())")
        let background = try BackgroundModifier(jxValue: jxValue)
        let _ = background.view(errorHandler: errorHandler)
        
        expectingError {
            jxValue = try context.eval("swiftui.EmptyView().background({alignment: 'invalid'}, swiftui.EmptyView())")
            let _ = try BackgroundModifier(jxValue: jxValue)
        }
    }
}
