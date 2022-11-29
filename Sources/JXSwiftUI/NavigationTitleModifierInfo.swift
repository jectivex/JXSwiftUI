import JXBridge
import JXKit
import SwiftUI

/// Sets a navigation title for its target view.
struct NavigationTitleModifierInfo: ElementInfo {
    private let targetInfo: ElementInfo
    private let title: String
    
    init(jxValue: JXValue) throws {
        self.targetInfo = try Self.info(for: jxValue["target"], in: .navigationTitleModifier)
        self.title = try jxValue["title"].string
    }

    var elementType: ElementType {
        return .navigationTitleModifier
    }
    
    @ViewBuilder
    func view(errorHandler: ErrorHandler?) -> any View {
        AnyView(targetInfo.view(errorHandler: errorHandler))
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
