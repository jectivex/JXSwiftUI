import JXBridge
import JXKit
@testable import JXSwiftUI
import XCTest

final class BorderModifierTests: JXSwiftUITestsBase {
    func testColorString() throws {
        let jxValue = try context.eval("jxswiftui.EmptyView().border('red')")
        let border = try BorderModifier(jxValue: jxValue)
        let _ = border.view(errorHandler: errorHandler)
    }

    func testWidth() throws {
        let jxValue = try context.eval("jxswiftui.EmptyView().border({width: 2}, jxswiftui.Color.red)")
        let border = try BorderModifier(jxValue: jxValue)
        let _ = border.view(errorHandler: errorHandler)
    }
}
