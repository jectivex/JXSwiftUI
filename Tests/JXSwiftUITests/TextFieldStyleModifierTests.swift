import JXBridge
import JXKit
@testable import JXSwiftUI
import XCTest

final class TextFieldStyleModifierTests: JXSwiftUITestsBase {
    func testTextFieldStyleModifier() throws {
        let sampleStyles = ["automatic", "plain", "roundedBorder"]
        for style in sampleStyles {
            try textFieldStyleTest(style)
        }
    }

    func textFieldStyleTest(_ style: String) throws {
        let jxValue = try context.eval("jxswiftui.EmptyView().textFieldStyle('\(style)')")
        let textFieldStyle = try TextFieldStyleModifier(jxValue: jxValue)
        let _ = textFieldStyle.view(errorHandler: errorHandler)
    }
}
