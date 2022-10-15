import JXKit
import SwiftUI

/// A SwiftUI view that displays content defined in JavaScript.
public struct JXView: View {
    public let context: JXContext
    public let bodyClosure: (JXContext) throws -> JXValue

    public init(context: JXContext? = nil, body: @escaping (JXContext) throws -> JXValue) {
        self.context = context ?? JXContext()
        self.bodyClosure = body
        do {
            try self.context.importSwiftUI()
        } catch {
            // TODO: Error handling
            print(error)
        }
    }

    public var body: some View {
        TypeSwitchView(bodyInfo)
    }

    private var bodyInfo: ElementInfo {
        do {
            let value = try bodyClosure(context)
            return try JXElementInfo.info(for: value, in: "JXView")
        } catch {
            // TODO: Error handling
            print(error)
            return EmptyInfo()
        }
    }
}
