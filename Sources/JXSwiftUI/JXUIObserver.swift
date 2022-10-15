import Combine

/// SImple observable used to trigger changes from JS.
class JXUIObserver: ObservableObject {
    func willChange() {
        self.objectWillChange.send()
    }
}
