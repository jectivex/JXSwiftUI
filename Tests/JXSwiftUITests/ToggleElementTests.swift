import JXBridge
import JXKit
@testable import JXSwiftUI
import SwiftUI
import XCTest

final class TextToggleElementTests: JXSwiftUITestsBase {
    func testStringLabel() throws {
        var value = ""
        let binding = Binding(get: { return value }, set: { value = $0 })
        let jxValue = try context.evalClosure("return jxswiftui.Toggle($0, 'Label')", withArguments: [binding])
        let toggle = try ToggleElement(jxValue: jxValue)
        let _ = toggle.view(errorHandler: errorHandler)
    }

    func testViewLabel() throws {
        var value = ""
        let binding = Binding(get: { return value }, set: { value = $0 })
        let jxValue = try context.evalClosure("return jxswiftui.Toggle($0, jxswiftui.Text('Label'))", withArguments: [binding])
        let toggle = try ToggleElement(jxValue: jxValue)
        let _ = toggle.view(errorHandler: errorHandler)
    }
}
