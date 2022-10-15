import JXKit

struct JXVStackInfo: VStackInfo {
    init(jxValue: JXValue) throws {
        self.contentInfo = try JXElementInfo.infoArray(for: jxValue["content"], in: "VStack")
    }

    var elementType: ElementType {
        return .vstack
    }

    let contentInfo: [ElementInfo]
}
