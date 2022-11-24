import Combine
import JXKit
import SwiftUI

/// A view with custom content defined by a script.
struct CustomView: View {
    let info: CustomInfo
    let errorHandler: ErrorHandler?

    @StateObject private var trigger = Trigger()

    var body: some View {
        contentInfo.view(errorHandler: errorHandler)
            .onReceive(onJSStateWillChange) {
                withAnimation { trigger.objectWillChange.send() }
            }
    }

    private var onJSStateWillChange: AnyPublisher<Void, Never> {
        return info.onJSStateWillChange
    }

    private var contentInfo: ElementInfo {
        do {
            return try info.contentInfo
        } catch {
            errorHandler?(error)
            return EmptyInfo()
        }
    }
}

struct CustomInfo: ElementInfo {
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
            return try Self.info(for: bodyValue, in: className)
        }
    }
}

private class Trigger: ObservableObject {
}
