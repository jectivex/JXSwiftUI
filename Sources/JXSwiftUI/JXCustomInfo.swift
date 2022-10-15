import Combine
import JXKit
import SwiftUI

struct JXCustomInfo: CustomInfo {
    private let jxValue: JXValue
    private let observer = JXUIObserver()

    init(jxValue: JXValue) throws {
        self.jxValue = jxValue
        let observerValue = jxValue.context.object(peer: self.observer)
        try jxValue.setProperty(JSCodeGenerator.observerProperty, observerValue)
    }

    var elementType: ElementType {
        return .custom
    }

    var onChange: AnyPublisher<Void, Never> {
        return observer.objectWillChange.eraseToAnyPublisher()
    }

    var contentInfo: ElementInfo {
        get throws {
            let bodyValue = try jxValue.invokeMethod(JSCodeGenerator.bodyFunction, withArguments: [])
            let className = try jxValue["constructor"]["name"].string
            return try JXElementInfo.info(for: bodyValue, in: className)
        }
    }
}
