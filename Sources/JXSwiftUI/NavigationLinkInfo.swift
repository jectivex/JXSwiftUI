import JXBridge
import JXKit
import SwiftUI

/// Vends a `SwiftUI.NavigationLink`.
struct NavigationLinkInfo: ElementInfo {
    private let contentInfo: ElementInfo
    private let destinationFunction: JXValue

    init(jxValue: JXValue) throws {
        self.contentInfo = try Self.info(for: jxValue["content"], in: .navigationLink)
        self.destinationFunction = try jxValue["destinationFunction"]
        guard destinationFunction.isFunction else {
            throw JXSwiftUIErrors.valueNotFunction(elementType.rawValue, "destinationFunction")
        }
    }

    var elementType: ElementType {
        return .navigationLink
    }
    
    @ViewBuilder
    func view(errorHandler: ErrorHandler?) -> any View {
        NavigationLink(destination: {
            AnyView(destination(errorHandler: errorHandler).view(errorHandler: errorHandler))
        }) {
            AnyView(contentInfo.view(errorHandler: errorHandler))
        }
    }
    
    static func js(namespace: JXNamespace) -> String? {
        // NavigationLink('label', () => { <destination> }) or NavigationLink(() => { <destination> }, <content>)
        """
function(destinationFunctionOrLabel, contentOrDestinationFunction) {
    const e = new \(namespace.value).JXElement('\(ElementType.navigationLink.rawValue)');
    if (typeof(destinationFunctionOrLabel) === 'string') {
        e.destinationFunction = contentOrDestinationFunction;
        e.content = \(namespace.value).Text(destinationFunctionOrLabel);
    } else {
        e.destinationFunction = destinationFunctionOrLabel;
        e.content = contentOrDestinationFunction;
    }
    return e;
}
"""
    }
    
    private func destination(errorHandler: ErrorHandler?) -> ElementInfo {
        do {
            let destinationValue = try destinationFunction.call(withArguments: [])
            return try Self.info(for: destinationValue, in: elementType)
        } catch {
            errorHandler?(error)
            return EmptyInfo()
        }
    }
}

