import JXBridge
import JXKit
@testable import JXSwiftUI
import XCTest

class JXSwiftUITestsBase: XCTestCase {
    var context: JXContext!
    var errorHandler = ErrorHandler(handler: { XCTFail("\($0)") }, elementPath: [])
    
    override func setUpWithError() throws {
        self.context = JXContext()
        try context.registry.register(JXSwiftUI())
    }
    
    func expectingError(run: () throws -> Void) {
        let previousErrorHandler = errorHandler
        var errorHandlerError: Error? = nil
        errorHandler = ErrorHandler(handler: { errorHandlerError = $0 }, elementPath: [])
        defer { errorHandler = previousErrorHandler }
        do {
            try run()
            if let errorHandlerError {
                throw errorHandlerError
            }
            XCTFail("Expected an error")
        } catch {
        }
    }
}
