import JXBridge
import JXKit
@testable import JXSwiftUI
import XCTest

class ElementTestsBase: XCTestCase {
    var context: JXContext!
    let errorHandler = ErrorHandler(handler: { XCTFail("\($0)") }, elementPath: [])
    
    override func setUpWithError() throws {
        self.context = JXContext()
        try context.registry.register(JXSwiftUI())
    }
}
