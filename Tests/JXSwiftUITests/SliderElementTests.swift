import JXBridge
import JXKit
@testable import JXSwiftUI
import SwiftUI
import XCTest

final class SliderElementTests: JXSwiftUITestsBase {
    func testValue() throws {
        var value = 0.0
        let binding = Binding(get: { return value }, set: { value = $0 })
        let jxValue = try context.evalClosure("return jxswiftui.Slider($0)", withArguments: [binding])
        let slider = try SliderElement(jxValue: jxValue)
        let _ = slider.view(errorHandler: errorHandler)
    }
    
    func testLabel() throws {
        var value = 0.0
        let binding = Binding(get: { return value }, set: { value = $0 })
        var jxValue = try context.evalClosure("return jxswiftui.Slider($0, 'label')", withArguments: [binding])
        var slider = try SliderElement(jxValue: jxValue)
        let _ = slider.view(errorHandler: errorHandler)

        jxValue = try context.evalClosure("return jxswiftui.Slider($0, {}, jxswiftui.Text('label'))", withArguments: [binding])
        slider = try SliderElement(jxValue: jxValue)
        let _ = slider.view(errorHandler: errorHandler)
    }
    
    func testValueProps() throws {
        var value = 0.0
        let binding = Binding(get: { return value }, set: { value = $0 })
        let jxValue = try context.evalClosure("return jxswiftui.Slider($0, {minimumValue: 10, maximumValue: 20, step: 2})", withArguments: [binding])
        let slider = try SliderElement(jxValue: jxValue)
        let _ = slider.view(errorHandler: errorHandler)
    }
    
    func testLabelProps() throws {
        var value = 0.0
        let binding = Binding(get: { return value }, set: { value = $0 })
        let jxValue = try context.evalClosure("return jxswiftui.Slider($0, {label: 'label', minimumValueLabel: jxswiftui.EmptyView(), maximumValueLabel: 'max'})", withArguments: [binding])
        let slider = try SliderElement(jxValue: jxValue)
        let _ = slider.view(errorHandler: errorHandler)
    }
}
