import JXBridge
import JXKit
@testable import JXSwiftUI
import XCTest

final class TextContentTypeModifierTests: JXSwiftUITestsBase {
    func testTextContentType() throws {
        let sampleTypes = ["username", "password", "emailAddress"]
        for type in sampleTypes {
            try textContentTypeTest(type)
        }
    }

    func textContentTypeTest(_ type: String) throws {
        let jxValue = try context.eval("jxswiftui.EmptyView().textContentType('\(type)')")
        let textContentType = try TextContentTypeModifier(jxValue: jxValue)
        let _ = textContentType.view(errorHandler: errorHandler)
    }
}
