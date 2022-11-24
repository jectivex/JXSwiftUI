import Combine
import SwiftUI

protocol CustomInfo: ElementInfo {
    var onJSStateWillChange: AnyPublisher<Void, Never> { get throws }
    var contentInfo: ElementInfo { get throws }
}

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
        do {
            return try info.onJSStateWillChange
        } catch {
            errorHandler?(error)
            return PassthroughSubject().eraseToAnyPublisher()
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
