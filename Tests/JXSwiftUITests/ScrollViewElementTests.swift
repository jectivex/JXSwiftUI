import JXBridge
import JXKit
@testable import JXSwiftUI
import XCTest

final class ScrollViewElementTests: JXSwiftUITestsBase {
    func testNoProps() throws {
        let jxValue = try context.eval("swiftui.ScrollView(swiftui.EmptyView())")
        let scrollView = try ScrollViewElement(jxValue: jxValue)
        let _ = scrollView.view(errorHandler: errorHandler)
    }
    
    func testContentArray() throws {
        let jxValue = try context.eval("swiftui.ScrollView([swiftui.EmptyView()])")
        expectingError {
            let scrollView = try ScrollViewElement(jxValue: jxValue)
            let _ = scrollView.view(errorHandler: errorHandler)
        }
    }

    func testProps() throws {
        let jxValue = try context.eval("swiftui.ScrollView({showsIndicators: true, axes: ['horizontal']}, swiftui.EmptyView())")
        let scrollView = try ScrollViewElement(jxValue: jxValue)
        let _ = scrollView.view(errorHandler: errorHandler)
    }
    
    func testInvalidAxes() throws {
        let jxValue = try context.eval("swiftui.ScrollView({axes: ['invalid']}, swiftui.EmptyView())")
        expectingError {
            let scrollView = try ScrollViewElement(jxValue: jxValue)
            let _ = scrollView.view(errorHandler: errorHandler)
        }
    }
}
