#if !os(macOS)
import JXBridge
import JXKit
@testable import JXSwiftUI
import XCTest

final class AutocorrectionDisabledModifierTests: JXSwiftUITestsBase {
    func testEmpty() throws {
        let jxValue = try context.eval("jxswiftui.EmptyView().autocorrectionDisabled()")
        let autocorrection = try AutocorrectionDisabledModifier(jxValue: jxValue)
        let _ = autocorrection.view(errorHandler: errorHandler)
    }

    func testBool() throws {
        let jxValue = try context.eval("jxswiftui.EmptyView().autocorrectionDisabled(true)")
        let autocorrection = try AutocorrectionDisabledModifier(jxValue: jxValue)
        let _ = autocorrection.view(errorHandler: errorHandler)
    }
}
#endif
