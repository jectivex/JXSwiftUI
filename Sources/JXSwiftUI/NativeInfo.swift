import JXBridge
import JXKit
import SwiftUI

/// Vends a custom native view.
struct NativeInfo: ElementInfo {
    private let view: any View

    init(jxValue: JXValue) throws {
        self.view = try jxValue.convey()
    }

    var elementType: ElementType {
        return .native
    }
    
    func view(errorHandler: ErrorHandler?) -> any View {
        return view
    }
    
    static func js(namespace: JXNamespace) -> String? {
        return nil
    }
}
