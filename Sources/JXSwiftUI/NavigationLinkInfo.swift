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

