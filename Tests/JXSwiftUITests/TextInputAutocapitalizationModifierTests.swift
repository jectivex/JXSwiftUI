#if !os(macOS)
import JXBridge
import JXKit
@testable import JXSwiftUI
import XCTest

final class TextInputAutocapitalizationModifierTests: JXSwiftUITestsBase {
    func testAutocapitalizationType() throws {
        let sampleTypes = ["characters", "never", "words"]
        for type in sampleTypes {
            try autocapitalizationTest(type)
        }
    }

    func autocapitalizationTest(_ type: String) throws {
        let jxValue = try context.eval("jxswiftui.EmptyView().textInputAutocapitalization('\(type)')")
        let autocapitalization = try TextInputAutocapitalizationModifier(jxValue: jxValue)
        let _ = autocapitalization.view(errorHandler: errorHandler)
    }
}
#endif
