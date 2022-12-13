import JXBridge
import JXKit
import SwiftUI

/// Vends a native view.
struct NativeElement: Element {
    private let view: any View

    init(jxValue: JXValue) throws {
        self.view = try jxValue.convey()
    }
    
    init(view: any View) {
        self.view = view
    }

    func view(errorHandler: ErrorHandler?) -> any View {
        return view
    }
    
    static func js(namespace: JXNamespace) -> String? {
        return nil
    }
}
