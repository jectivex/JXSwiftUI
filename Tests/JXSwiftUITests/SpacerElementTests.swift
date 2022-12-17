import JXBridge
import JXKit
@testable import JXSwiftUI
import XCTest

final class SpacerElementTests: JXSwiftUITestsBase {
    func testSpacer() throws {
        let jxValue = try context.eval("jxswiftui.Spacer()")
        let spacer = try SpacerElement(jxValue: jxValue)
        let _ = spacer.view(errorHandler: errorHandler)
    }
    
    func testMinLength() throws {
        let jxValue = try context.eval("jxswiftui.Spacer(12)")
        let spacer = try SpacerElement(jxValue: jxValue)
        let _ = spacer.view(errorHandler: errorHandler)
    }
}
