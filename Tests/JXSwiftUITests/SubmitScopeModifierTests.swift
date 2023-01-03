import JXBridge
import JXKit
@testable import JXSwiftUI
import XCTest

final class SubmitScopeModifierTests: JXSwiftUITestsBase {
    func testEmpty() throws {
        let jxValue = try context.eval("jxswiftui.EmptyView().submitScope()")
        let scope = try SubmitScopeModifier(jxValue: jxValue)
        let _ = scope.view(errorHandler: errorHandler)
    }

    func testBool() throws {
        let jxValue = try context.eval("jxswiftui.EmptyView().submitScope(true)")
        let scope = try SubmitScopeModifier(jxValue: jxValue)
        let _ = scope.view(errorHandler: errorHandler)
    }
}
