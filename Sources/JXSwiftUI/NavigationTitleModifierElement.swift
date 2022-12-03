import JXBridge
import JXKit
import SwiftUI

/// Sets a navigation title for its target view.
struct NavigationTitleModifierElement: Element {
    private let target: Content
    private let title: String
    
    init(jxValue: JXValue) throws {
        self.target = try Content(jxValue: jxValue["target"])
        self.title = try jxValue["title"].string
    }

    var elementType: ElementType {
        return .navigationTitleModifier
    }
    
    func view(errorHandler: ErrorHandler?) -> any View {
        return target.element(errorHandler: errorHandler)
            .view(errorHandler: errorHandler)
            .navigationTitle(title)
    }
    
    static func js(namespace: JXNamespace) -> String? {
        """
function(target, title) {
    const e = new \(namespace.value).JXElement('\(ElementType.navigationTitleModifier.rawValue)');
    e.target = target;
    e.title = title;
    return e;
}
"""
    }
}
