import JXBridge
import JXKit
@testable import JXSwiftUI
import XCTest

final class ScrollViewElementTests: JXSwiftUITestsBase {
    func testNoProps() throws {
        let jxValue = try context.eval("jxswiftui.ScrollView(jxswiftui.EmptyView())")
        let scrollView = try ScrollViewElement(jxValue: jxValue)
        let _ = scrollView.view(errorHandler: errorHandler)
    }
    
    func testContentArray() throws {
        let jxValue = try context.eval("jxswiftui.ScrollView([jxswiftui.EmptyView()])")
        expectingError {
            let scrollView = try ScrollViewElement(jxValue: jxValue)
            let _ = scrollView.view(errorHandler: errorHandler)
        }
    }

    func testProps() throws {
        let jxValue = try context.eval("jxswiftui.ScrollView({showsIndicators: true, axes: ['horizontal']}, jxswiftui.EmptyView())")
        let scrollView = try ScrollViewElement(jxValue: jxValue)
        let _ = scrollView.view(errorHandler: errorHandler)
    }
    
    func testInvalidAxes() throws {
        let jxValue = try context.eval("jxswiftui.ScrollView({axes: ['invalid']}, jxswiftui.EmptyView())")
        expectingError {
            let scrollView = try ScrollViewElement(jxValue: jxValue)
            let _ = scrollView.view(errorHandler: errorHandler)
        }
    }
}
