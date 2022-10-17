import JXKit

struct JXHStackInfo: HStackInfo {
    init(jxValue: JXValue) throws {
        self.contentInfo = try JXElementInfo.infoArray(for: jxValue["content"], in: "HStack")
    }

    var elementType: ElementType {
        return .hstack
    }

    let contentInfo: [ElementInfo]
}