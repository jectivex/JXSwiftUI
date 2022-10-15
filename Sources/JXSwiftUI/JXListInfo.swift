import JXKit

struct JXListInfo: ListInfo {
    init(jxValue: JXValue) throws {
        self.contentInfo = try JXElementInfo.infoArray(for: jxValue["content"], in: "List")
    }

    var elementType: ElementType {
        return .list
    }

    let contentInfo: [ElementInfo]
}
