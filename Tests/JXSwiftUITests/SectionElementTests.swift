import JXBridge
import JXKit
@testable import JXSwiftUI
import XCTest

final class SectionElementTests: JXSwiftUITestsBase {
    func testContent() throws {
        var jxValue = try context.eval("swiftui.Section([])")
        var section = try SectionElement(jxValue: jxValue)
        let _ = section.view(errorHandler: errorHandler)
        
        jxValue = try context.eval("swiftui.Section([swiftui.EmptyView()])")
        section = try SectionElement(jxValue: jxValue)
        let _ = section.view(errorHandler: errorHandler)
        
        jxValue = try context.eval("swiftui.Section(swiftui.EmptyView())")
        expectingError {
            section = try SectionElement(jxValue: jxValue)
            let _ = section.view(errorHandler: errorHandler)
        }
    }
    
    func testHeaderLabel() throws {
        let jxValue = try context.eval("swiftui.Section('header', [swiftui.EmptyView()])")
        let section = try SectionElement(jxValue: jxValue)
        let _ = section.view(errorHandler: errorHandler)
    }
    
    func testHeaderFooterProps() throws {
        let jxValue = try context.eval("swiftui.Section({header: 'header', footer: swiftui.EmptyView()}, [swiftui.EmptyView()])")
        let section = try SectionElement(jxValue: jxValue)
        let _ = section.view(errorHandler: errorHandler)
    }
}
