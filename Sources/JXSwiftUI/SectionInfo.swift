import JXBridge
import JXKit
import SwiftUI

/// Vends a `SwiftUI.Section` view.
struct SectionInfo: ElementInfo {
    private let headerContentInfo: ElementInfo
    private let footerContentInfo: ElementInfo
    private let contentInfo: [ElementInfo]
    
    init(jxValue: JXValue) throws {
        let headerValue = try jxValue["header"]
        self.headerContentInfo = headerValue.isUndefined ? EmptyInfo() : try Self.info(for: headerValue, in: .section)
        let footerValue = try jxValue["footer"]
        self.footerContentInfo = footerValue.isUndefined ? EmptyInfo() : try Self.info(for: footerValue, in: .section)
        self.contentInfo = try Self.infoArray(for: jxValue["content"], in: .section)
    }

    var elementType: ElementType {
        return .section
    }
    
    @ViewBuilder
    func view(errorHandler: ErrorHandler?) -> any View {
        Section(content: {
            contentInfo.containerView(errorHandler: errorHandler)
        }, header: {
            AnyView(headerContentInfo.view(errorHandler: errorHandler))
        }, footer: {
            AnyView(footerContentInfo.view(errorHandler: errorHandler))
        })
    }
    
    static func js(namespace: JXNamespace) -> String? {
        // Section('header', [<content>]) or Section({ header: <content>, footer: <content> }, [<content>]) or Section([<content>])
        """
function(propsOrContentArray, contentArray) {
    const e = new \(namespace.value).JXElement('\(ElementType.section.rawValue)');
    if (contentArray === undefined) {
        e.content = propsOrContentArray;
    } else {
        if (typeof(propsOrContentArray) === 'string') {
            e.header = \(namespace.value).Text(propsOrContentArray);
        } else {
            e.header = props.header;
            e.footer = proper.footer;
        }
        e.content = contentArray;
    }
    return e;
}
"""
    }
}
