import JXBridge
import JXKit
import SwiftUI

extension JXSwiftUISupport {
    /// Sets the aspect ratio of a target view.
    ///
    /// Supported calls:
    ///
    ///     - .aspectRatio(ContentMode)
    ///     - .aspectRatio(ratio, ContentMode)
    ///     - .aspectRatio(size, ContentMode)
    public enum aspectRatio {}

    /// Use a JavaScript string to name any standard `ContentMode` value, e.g. 'fit'.
    public enum ContentMode {}
}

struct AspectRatioModifier: Element {
    private let target: Content
    private let ratio: CGFloat?
    private let contentMode: ContentMode

    init(jxValue: JXValue) throws {
        self.target = try Content(jxValue: jxValue["target"])
        let args = try jxValue["args"].array
        if args.isEmpty {
            throw JXError.missingContent()
        } else if args.count == 1 {
            self.ratio = nil
            self.contentMode = try args[0].convey()
        } else if args[0].isNumber {
            self.ratio = try args[0].double
            self.contentMode = try args[1].convey()
        } else {
            let size = try args[0].convey(to: CGSize.self)
            self.ratio = size.height == 0.0 ? 0.0 : size.width / size.height
            self.contentMode = try args[1].convey()
        }
    }

    func view(errorHandler: ErrorHandler) -> any View {
        return target.element(errorHandler: errorHandler)
            .view(errorHandler: errorHandler)
            .aspectRatio(ratio, contentMode: contentMode)
    }

    static func modifierJS(namespace: JXNamespace) -> String? {
        return """
function(...args) {
    const e = new \(JSCodeGenerator.elementClass)('\(ElementType.aspectRatioModifier.rawValue)');
    e.target = this;
    e.args = args;
    return e;
}
"""
    }
}

extension ContentMode: RawRepresentable {
    public init?(rawValue: String) {
        switch rawValue {
        case "fill":
            self = .fill
        case "fit":
            self = .fit
        default:
            return nil
        }
    }

    public var rawValue: String {
        switch self {
        case .fill:
            return "fill"
        case .fit:
            return "fit"
        }
    }
}
