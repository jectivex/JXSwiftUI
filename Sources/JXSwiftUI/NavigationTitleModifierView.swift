import JXKit
import SwiftUI

/// A view that specifies a navigation title forr its target view.
struct NavigationTitleModifierView: View {
    let info: NavigationTitleModifierInfo
    let errorHandler: ErrorHandler?

    var body: some View {
        info.targetInfo.view(errorHandler: errorHandler)
            .navigationTitle(info.title)
    }
}

struct NavigationTitleModifierInfo: ElementInfo {
    init(jxValue: JXValue) throws {
        self.targetInfo = try Self.info(for: jxValue["target"], in: .navigationTitleModifier)
        self.title = try jxValue["title"].string
    }

    var elementType: ElementType {
        return .navigationTitleModifier
    }

    let targetInfo: ElementInfo

    let title: String
}
