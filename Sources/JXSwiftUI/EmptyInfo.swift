/// Info for an empty view.
struct EmptyInfo: ElementInfo {
    init() {
    }
    
    var elementType: ElementType {
        return .empty
    }
}
