#if !os(macOS)
import JXBridge
import JXKit
@testable import JXSwiftUI
import XCTest

final class KeyboardTypeModifierTests: JXSwiftUITestsBase {
    func testKeyboardType() throws {
        let sampleTypes = ["default", "URL", "phonePad"]
        for type in sampleTypes {
            try keyboardTypeTest(type)
        }
    }

    func keyboardTypeTest(_ type: String) throws {
        let jxValue = try context.eval("jxswiftui.EmptyView().keyboardType('\(type)')")
        let keyboardType = try KeyboardTypeModifier(jxValue: jxValue)
        let _ = keyboardType.view(errorHandler: errorHandler)
    }
}
#endif
