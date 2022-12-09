import JXBridge
import JXKit
import SwiftUI

/// Vends a `SwiftUI.Section` view.
struct SectionElement: Element {
    private let headerContent: Content?
    private let footerContent: Content?
    private let content: Content
    
    init(jxValue: JXValue) throws {
        let headerValue = try jxValue["header"]
        self.headerContent = headerValue.isNullOrUndefined ? nil : Content(jxValue: headerValue)
        let footerValue = try jxValue["footer"]
        self.footerContent = footerValue.isNullOrUndefined ? nil : Content(jxValue: footerValue)
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
        // Section('header', [<content>]) or Section({ header: <content>, footer: <content> }, [<content>]) or Section([<content>])
        """
function(propsOrContentArray, contentArray) {
    const e = new \(JXNamespace.default).\(JSCodeGenerator.elementClass)('\(ElementType.section.rawValue)');
    if (contentArray === undefined) {
        e.content = propsOrContentArray;
        e.header = null;
        e.footer = null;
    } else {
        if (typeof(propsOrContentArray) === 'string') {
            e.header = \(namespace).Text(propsOrContentArray);
            e.footer = null;
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
