import JXBridge
import JXKit
@testable import JXSwiftUI
import XCTest

final class ForegroundColorModifierTests: JXSwiftUITestsBase {
    func testColorName() throws {
        let jxValue = try context.eval("jxswiftui.EmptyView().foregroundColor('customColor')")
        let foregroundColor = try ForegroundColorModifier(jxValue: jxValue)
        let _ = foregroundColor.view(errorHandler: errorHandler)
    }
    
    func testColor() throws {
        let jxValue = try context.eval("jxswiftui.EmptyView().foregroundColor(jxswiftui.Color.red)")
        let foregroundColor = try ForegroundColorModifier(jxValue: jxValue)
        let _ = foregroundColor.view(errorHandler: errorHandler)
    }
}
