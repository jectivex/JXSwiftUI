import Combine
import JXBridge
import JXKit
import SwiftUI

/// Vends a custom view defined in JS.
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
    
    @ViewBuilder
    func view(errorHandler: ErrorHandler?) -> any View {
        CustomView(info: self, errorHandler: errorHandler)
    }
    
    static func js(namespace: JXNamespace) -> String? {
        return nil
    }

    fileprivate var onJSStateWillChange: AnyPublisher<Void, Never> {
        return observer.objectWillChange.eraseToAnyPublisher()
    }

    fileprivate var contentInfo: ElementInfo {
        get throws {
            let bodyValue = try jxValue.invokeMethod(JSCodeGenerator.bodyFunction, withArguments: [])
            let className = try jxValue["constructor"]["name"].string
            return try Self.info(for: bodyValue, in: className)
        }
    }
}

private struct CustomView: View {
    let info: CustomInfo
    let errorHandler: ErrorHandler?

    @StateObject private var trigger = Trigger()

    var body: some View {
        AnyView(contentInfo.view(errorHandler: errorHandler))
            .onReceive(info.onJSStateWillChange) {
                withAnimation { trigger.objectWillChange.send() }
            }
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

private class Trigger: ObservableObject {
}