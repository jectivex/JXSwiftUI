import JXBridge
import JXKit
import SwiftUI

/// Vends a `SwiftUI.NavigationLink`.
struct NavigationLinkElement: Element {
    private let content: Content
    private let destination: Content

    init(jxValue: JXValue) throws {
        self.content = try Content(jxValue: jxValue["content"])
        self.destination = try Content(jxValue: jxValue["destinationFunction"])
    }

    func view(errorHandler: ErrorHandler?) -> any View {
        let errorHandler = errorHandler?.in(.navigationLink)
        return NavigationLink(destination: {
            let errorHandler = errorHandler?.attr("destination")
            return destination.element(errorHandler: errorHandler)
                .view(errorHandler: errorHandler)
                .eraseToAnyView()
        }) {
            content.element(errorHandler: errorHandler)
                .view(errorHandler: errorHandler)
                .eraseToAnyView()
        }
    }
    
    static func js(namespace: JXNamespace) -> String? {
        // NavigationLink('label', () => { <destination> }) or NavigationLink(() => { <destination> }, <content>)
        """
function(destinationFunctionOrLabel, contentOrDestinationFunction) {
    const e = new \(namespace).JXElement('\(ElementType.navigationLink.rawValue)');
    if (typeof(destinationFunctionOrLabel) === 'string') {
        e.destinationFunction = contentOrDestinationFunction;
        e.content = \(namespace).Text(destinationFunctionOrLabel);
    } else {
        e.destinationFunction = destinationFunctionOrLabel;
        e.content = contentOrDestinationFunction;
    }
    return e;
}
"""
    }
}

