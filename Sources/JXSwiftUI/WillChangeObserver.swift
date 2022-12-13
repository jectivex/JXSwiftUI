import Combine

/// SImple observable used to trigger changes from JS.
class WillChangeObserver: ObservableObject {
    func willChange() {
        self.objectWillChange.send()
    }
}
