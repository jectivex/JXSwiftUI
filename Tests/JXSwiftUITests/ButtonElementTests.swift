import JXBridge
import JXKit
@testable import JXSwiftUI
import XCTest

final class ButtonElementTests: JXSwiftUITestsBase {
    func testLabelFirst() throws {
        let jxValue = try context.eval("swiftui.Button('label', () => {})")
        let button = try ButtonElement(jxValue: jxValue)
        let _ = button.view(errorHandler: errorHandler)
    }
    
    func testStringContent() throws {
        let jxValue = try context.eval("swiftui.Button(() => {}, 'label')")
        let button = try ButtonElement(jxValue: jxValue)
        let _ = button.view(errorHandler: errorHandler)
    }
    
    func testContent() throws {
        let jxValue = try context.eval("swiftui.Button(() => {}, swiftui.EmptyView())")
        let button = try ButtonElement(jxValue: jxValue)
        let _ = button.view(errorHandler: errorHandler)
    }
    
    func testRole() throws {
        var jxValue = try context.eval("swiftui.Button({role: 'cancel'}, () => {}, swiftui.EmptyView())")
        let button = try ButtonElement(jxValue: jxValue)
        let _ = button.view(errorHandler: errorHandler)
        
        expectingError {
            jxValue = try context.eval("swiftui.Button({role: 'invalid'}, () => {}, swiftui.EmptyView())")
            let _ = try ButtonElement(jxValue: jxValue)
        }
    }
    
    func testPropsLabel() throws {
        var jxValue = try context.eval("swiftui.Button({role: 'cancel', label: 'label'}, () => {})")
        let button = try ButtonElement(jxValue: jxValue)
        let _ = button.view(errorHandler: errorHandler)
        
        expectingError {
            jxValue = try context.eval("swiftui.Button({role: 'cancel'}, () => {})")
            let _ = try ButtonElement(jxValue: jxValue)
        }
    }
}
