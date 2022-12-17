import JXBridge
import JXKit
@testable import JXSwiftUI
import XCTest

final class NavigationLinkElementTests: JXSwiftUITestsBase {
    func testLabelFirst() throws {
        let jxValue = try context.eval("jxswiftui.NavigationLink('label', () => { return jxswiftui.EmptyView() })")
        let link = try NavigationLinkElement(jxValue: jxValue)
        let _ = link.view(errorHandler: errorHandler)
    }
    
    func testStringContent() throws {
        let jxValue = try context.eval("jxswiftui.NavigationLink(() => { return jxswiftui.EmptyView() }, 'label')")
        let link = try NavigationLinkElement(jxValue: jxValue)
        let _ = link.view(errorHandler: errorHandler)
    }
    
    func testContent() throws {
        let jxValue = try context.eval("jxswiftui.NavigationLink(() => { return jxswiftui.EmptyView() }, jxswiftui.EmptyView())")
        let link = try NavigationLinkElement(jxValue: jxValue)
        let _ = link.view(errorHandler: errorHandler)
    }
}
