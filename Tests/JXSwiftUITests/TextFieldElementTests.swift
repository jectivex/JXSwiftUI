import JXBridge
import JXKit
@testable import JXSwiftUI
import SwiftUI
import XCTest

final class TextFieldElementTests: JXSwiftUITestsBase {
    func testStringLabel() throws {
        var value = ""
        let binding = Binding(get: { return value }, set: { value = $0 })
        let jxValue = try context.evalClosure("return jxswiftui.TextField($0, 'Label')", withArguments: [binding])
        let textField = try TextFieldElement(jxValue: jxValue)
        let _ = textField.view(errorHandler: errorHandler)
    }

    func testPropsLabel() throws {
        var value = ""
        let binding = Binding(get: { return value }, set: { value = $0 })
        let jxValue = try context.evalClosure("return jxswiftui.TextField($0, {label: 'Label', prompt: 'Prompt'})", withArguments: [binding])
        let textField = try TextFieldElement(jxValue: jxValue)
        let _ = textField.view(errorHandler: errorHandler)
    }

    func testPropsAndLabel() throws {
        var value = ""
        let binding = Binding(get: { return value }, set: { value = $0 })
        let jxValue = try context.evalClosure("return jxswiftui.TextField($0, {prompt: 'Prompt'}, jxswiftui.Text('Label'))", withArguments: [binding])
        let textField = try TextFieldElement(jxValue: jxValue)
        let _ = textField.view(errorHandler: errorHandler)
    }
}
