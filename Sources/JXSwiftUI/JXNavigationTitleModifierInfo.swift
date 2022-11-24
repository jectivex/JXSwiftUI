import JXKit

struct JXNavigationTitleModifierInfo: NavigationTitleModifierInfo {
    init(jxValue: JXValue) throws {
        self.targetInfo = try JXElementInfo.info(for: jxValue["target"], in: .navigationTitleModifier)
        self.title = try jxValue["title"].string
    }

    var elementType: ElementType {
        return .navigationTitleModifier
    }

    let targetInfo: ElementInfo

    let title: String
}
