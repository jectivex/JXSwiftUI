import JXKit

struct JXNavigationViewInfo: NavigationViewInfo {
    init(jxValue: JXValue) throws {
        self.contentInfo = try JXElementInfo.info(for: jxValue["content"], in: .navigationView)
    }

    var elementType: ElementType {
        return .navigationView
    }

    let contentInfo: ElementInfo
}
