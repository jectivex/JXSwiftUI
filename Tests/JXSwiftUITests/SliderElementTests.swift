import JXBridge
import JXKit
@testable import JXSwiftUI
import SwiftUI
import XCTest

final class SliderElementTests: JXSwiftUITestsBase {
    func testValue() throws {
        var value = 0.0
        let binding = Binding(get: { return value }, set: { value = $0 })
        try context.withValues([binding]) {
            let jxValue = try context.eval("jxswiftui.Slider($0)")
            let slider = try SliderElement(jxValue: jxValue)
            let _ = slider.view(errorHandler: errorHandler)
        }
    }
    
    func testLabel() throws {
        var value = 0.0
        let binding = Binding(get: { return value }, set: { value = $0 })
        try context.withValues([binding]) {
            let jxValue = try context.eval("jxswiftui.Slider($0, 'label')")
            let slider = try SliderElement(jxValue: jxValue)
            let _ = slider.view(errorHandler: errorHandler)
        }
        try context.withValues([binding]) {
            let jxValue = try context.eval("jxswiftui.Slider($0, {}, jxswiftui.Text('label'))")
            let slider = try SliderElement(jxValue: jxValue)
            let _ = slider.view(errorHandler: errorHandler)
        }
    }
    
    func testValueProps() throws {
        var value = 0.0
        let binding = Binding(get: { return value }, set: { value = $0 })
        try context.withValues([binding]) {
            let jxValue = try context.eval("jxswiftui.Slider($0, {minimumValue: 10, maximumValue: 20, step: 2})")
            let slider = try SliderElement(jxValue: jxValue)
            let _ = slider.view(errorHandler: errorHandler)
        }
    }
    
    func testLabelProps() throws {
        var value = 0.0
        let binding = Binding(get: { return value }, set: { value = $0 })
        try context.withValues([binding]) {
            let jxValue = try context.eval("jxswiftui.Slider($0, {label: 'label', minimumValueLabel: jxswiftui.EmptyView(), maximumValueLabel: 'max'})")
            let slider = try SliderElement(jxValue: jxValue)
            let _ = slider.view(errorHandler: errorHandler)
        }
    }
}
