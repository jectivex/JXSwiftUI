import Combine
import JXKit
import SwiftUI

struct JXCustomInfo: CustomInfo {
    private let jxValue: JXValue
    private let observer = WillChangeObserver()

    init(jxValue: JXValue) throws {
        self.jxValue = jxValue
        // Set an observer that will be triggered on JS JXView.state changes
        let observerValue = jxValue.context.object(peer: self.observer)
        try jxValue[JSCodeGenerator.stateProperty].setProperty(JSCodeGenerator.observerProperty, observerValue)
    }

    var elementType: ElementType {
        return .custom
    }

    var onJSStateWillChange: AnyPublisher<Void, Never> {
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
