import JXKit

struct JXTextInfo: TextInfo {
    init(jxValue: JXValue) throws {
        self.text = try jxValue["text"].string
    }

    init(text: String) {
        self.text = text
    }

    var elementType: ElementType {
        return .text
    }

    let text: String
}
