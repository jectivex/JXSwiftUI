import JXBridge
import JXKit
@testable import JXSwiftUI
import XCTest

final class PickerStyleModifierTests: JXSwiftUITestsBase {
    func testPickerStyleModifier() throws {
        let sampleStyles = ["automatic", "inline", "segmented"]
        for style in sampleStyles {
            try pickerStyleTest(style)
        }
    }

    func pickerStyleTest(_ style: String) throws {
        let jxValue = try context.eval("jxswiftui.EmptyView().pickerStyle('\(style)')")
        let pickerStyle = try PickerStyleModifier(jxValue: jxValue)
        let _ = pickerStyle.view(errorHandler: errorHandler)
    }
}
