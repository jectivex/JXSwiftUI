import JXBridge
import JXKit
@testable import JXSwiftUI
import XCTest

final class ForEachElementTests: JXSwiftUITestsBase {
    func testNotArray() throws {
        let jxValue = try context.eval("swiftui.ForEach(1, () => {}, () => {})")
        expectingError {
            let foreach = try ForEachElement(jxValue: jxValue)
            let _ = foreach.view(errorHandler: errorHandler)
        }
    }
    
    func testNotContentFunction() throws {
        let jxValue = try context.eval("swiftui.ForEach([], () => {}, swiftui.EmptyView())")
        expectingError {
            let foreach = try ForEachElement(jxValue: jxValue)
            let _ = foreach.view(errorHandler: errorHandler)
        }
    }
    
    func testIdFunction() throws {
        let jxValue = try context.eval("swiftui.ForEach([{identity: 1}], (item) => { return item.identity; }, (item) => { return swiftui.EmptyView(); })")
        let foreach = try ForEachElement(jxValue: jxValue)
        let _ = foreach.view(errorHandler: errorHandler)
    }
    
    func testIdProperty() throws {
        let jxValue = try context.eval("swiftui.ForEach([{identity: 1}], 'identity', (item) => { return swiftui.EmptyView(); })")
        let foreach = try ForEachElement(jxValue: jxValue)
        let _ = foreach.view(errorHandler: errorHandler)
    }
    
    func testDefaultIdProperty() throws {
        let jxValue = try context.eval("swiftui.ForEach([{identity: 1}], (item) => { return swiftui.EmptyView(); })")
        let foreach = try ForEachElement(jxValue: jxValue)
        let _ = foreach.view(errorHandler: errorHandler)
    }
}
