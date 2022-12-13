import JXBridge
import JXKit
import SwiftUI

extension JXSwiftUISupport {
    /// A `SwiftUI.Section`.
    ///
    /// Supported usage:
    ///
    ///     - Section([content])
    ///     - Section('header', [content])
    ///     - Section({props}, [content])
    ///
    /// Supported `props`:
    ///
    ///     - header: String or content
    ///     - footer: String or content
    ///
    /// Supported section `content`:
    ///
    ///     - View array
    ///     - Anonymous function returning a View array
    ///
    /// Supported header and footer `content`:
    ///
    ///     - View
    ///     - Anonymous function returning a View
    public enum Section {}
}

struct SectionElement: Element {
    private let headerContent: Content?
    private let footerContent: Content?
    private let content: Content
    
    init(jxValue: JXValue) throws {
        self.headerContent = try Content.optional(jxValue: jxValue["header"])
        self.footerContent = try Content.optional(jxValue: jxValue["footer"])
        self.content = try Content(jxValue: jxValue["content"])
    }

    func view(errorHandler: ErrorHandler?) -> any View {
        let errorHandler = errorHandler?.in(.section)
        return Section(content: {
            content.elementArray(errorHandler: errorHandler)
                .containerView(errorHandler: errorHandler)
        }, header: {
            if let headerContent {
                let errorHandler = errorHandler?.attr("header")
                headerContent.element(errorHandler: errorHandler)
                    .view(errorHandler: errorHandler)
                    .eraseToAnyView()
            } else {
                EmptyView()
            }
        }, footer: {
            if let footerContent {
                let errorHandler = errorHandler?.attr("footer")
                footerContent.element(errorHandler: errorHandler)
                    .view(errorHandler: errorHandler)
                    .eraseToAnyView()
            } else {
                EmptyView()
            }
        })
    }
    
    static func js(namespace: JXNamespace) -> String? {
        """
function(propsOrContentArray, contentArray) {
    const e = new \(JXNamespace.default).\(JSCodeGenerator.elementClass)('\(ElementType.section.rawValue)');
    if (contentArray === undefined) {
        e.content = propsOrContentArray;
    } else {
        if (typeof(propsOrContentArray) === 'string') {
            e.header = propsOrContentArray;
        } else {
            e.header = propsOrContentArray.header;
            e.footer = propsOrContentArray.footer;
        }
        e.content = contentArray;
    }
    return e;
}
"""
    }
}
