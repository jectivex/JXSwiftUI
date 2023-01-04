import JXBridge
import JXKit
@testable import JXSwiftUI
import XCTest

final class LabelElementTests: JXSwiftUITestsBase {
    func testProps() throws {
        var jxValue = try context.eval("jxswiftui.Label({label: 'text', systemImage: 'pencil'})")
        var label = try LabelElement(jxValue: jxValue)
        let _ = label.view(errorHandler: errorHandler)

        jxValue = try context.eval("jxswiftui.Label({label: jxswiftui.Text('text'), image: 'pencil'})")
        label = try LabelElement(jxValue: jxValue)
        let _ = label.view(errorHandler: errorHandler)

        jxValue = try context.eval("jxswiftui.Label({label: jxswiftui.Text('text'), image: jxswiftui.Image.named('pencil', {label: 'label'})})")
        label = try LabelElement(jxValue: jxValue)
        let _ = label.view(errorHandler: errorHandler)

        jxValue = try context.eval("jxswiftui.Label({label: jxswiftui.Text('text'), icon: jxswiftui.Image.named('pencil', {label: 'label'})})")
        label = try LabelElement(jxValue: jxValue)
        let _ = label.view(errorHandler: errorHandler)

        expectingError {
            jxValue = try context.eval("jxswiftui.Label({systemImage: 'pencil'})")
            label = try LabelElement(jxValue: jxValue)
            let _ = label.view(errorHandler: errorHandler)
        }
        expectingError {
            jxValue = try context.eval("jxswiftui.Label({label: 'text'})")
            label = try LabelElement(jxValue: jxValue)
            let _ = label.view(errorHandler: errorHandler)
        }
    }
}
