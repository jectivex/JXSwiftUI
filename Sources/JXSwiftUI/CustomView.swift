import Combine
import SwiftUI

protocol CustomInfo: ElementInfo {
    var onChange: AnyPublisher<Void, Never> { get throws }
    var contentInfo: ElementInfo { get throws }
}

/// A view with custom content defined by a script.
struct CustomView: View {
    private let info: CustomInfo
    @StateObject private var trigger = Trigger()

    init(_ info: CustomInfo) {
        self.info = info
    }

    var body: some View {
        contentInfo.view
            .onReceive(onChange) {
                withAnimation { trigger.objectWillChange.send() }
            }
    }

    private var onChange: AnyPublisher<Void, Never> {
        do {
            return try info.onChange
        } catch {
            // TODO: Error handling
            return PassthroughSubject().eraseToAnyPublisher()
        }
    }

    private var contentInfo: ElementInfo {
        do {
            return try info.contentInfo
        } catch {
            // TODO: Error handling
            return EmptyInfo()
        }
    }
}

private class Trigger: ObservableObject {
}
