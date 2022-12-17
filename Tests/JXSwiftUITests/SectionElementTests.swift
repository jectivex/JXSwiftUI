import JXBridge
import JXKit
@testable import JXSwiftUI
import XCTest

final class SectionElementTests: JXSwiftUITestsBase {
    func testContent() throws {
        var jxValue = try context.eval("jxswiftui.Section([])")
        var section = try SectionElement(jxValue: jxValue)
        let _ = section.view(errorHandler: errorHandler)
        
        jxValue = try context.eval("jxswiftui.Section([jxswiftui.EmptyView()])")
        section = try SectionElement(jxValue: jxValue)
        let _ = section.view(errorHandler: errorHandler)
        
        jxValue = try context.eval("jxswiftui.Section(jxswiftui.EmptyView())")
        expectingError {
            section = try SectionElement(jxValue: jxValue)
            let _ = section.view(errorHandler: errorHandler)
        }
    }
    
    func testHeaderLabel() throws {
        let jxValue = try context.eval("jxswiftui.Section('header', [jxswiftui.EmptyView()])")
        let section = try SectionElement(jxValue: jxValue)
        let _ = section.view(errorHandler: errorHandler)
    }
    
    func testHeaderFooterProps() throws {
        let jxValue = try context.eval("jxswiftui.Section({header: 'header', footer: jxswiftui.EmptyView()}, [jxswiftui.EmptyView()])")
        let section = try SectionElement(jxValue: jxValue)
        let _ = section.view(errorHandler: errorHandler)
    }
}
