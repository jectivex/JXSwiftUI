import JXBridge
import JXKit
@testable import JXSwiftUI
import SwiftUI
import XCTest

final class PickerElementTests: JXSwiftUITestsBase {
    func testTaggedViews() throws {
        var value = ""
        let binding = Binding(get: { return value }, set: { value = $0 })
        let jxValue = try context.evalClosure("return jxswiftui.Picker($0, 'Label', [jxswiftui.Text('option1').tag('option1'), jxswiftui.Text('option2').tag('option2')])", withArguments: [binding])
        let picker = try PickerElement(jxValue: jxValue)
        let _ = picker.view(errorHandler: errorHandler)
    }

    func testForEach() throws {
        var value = 0
        let binding = Binding(get: { return value }, set: { value = $0 })
        let jxValue = try context.evalClosure("""
return jxswiftui.Picker($0, jxswiftui.Text('Label'), [
    jxswiftui.ForEach([{identity: 1}], (item) => { return item.identity; }, (item) => { return jxswiftui.Text('item1'); })
])
""", withArguments: [binding])
        let picker = try PickerElement(jxValue: jxValue)
        let _ = picker.view(errorHandler: errorHandler)
    }
}
