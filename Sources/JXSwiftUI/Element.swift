import JXBridge
import JXKit
import SwiftUI

/// Representation of a SwiftUI element.
protocol Element {
    init(jxValue: JXValue) throws
    func view(errorHandler: ErrorHandler?) -> any View
    
    static func js(namespace: JXNamespace) -> String?
    static func modifierJS(for modifier: String, namespace: JXNamespace) -> String?
}

extension Element {
    static func modifierJS(for modifier: String, namespace: JXNamespace) -> String? {
        return nil
    }
}

typealias JXSwiftUIElement = Element
extension Array where Element == JXSwiftUIElement {
    @ViewBuilder
    func containerView(errorHandler: ErrorHandler?) -> some View {
        // NOTE: ForEach caused a blank view followed by a crash after minutes
        // of no activity, so fallback to brute force
        switch self.count {
        case 0:
            Group {
            }
        case 1:
            AnyView(self[0].view(errorHandler: errorHandler?.in("0")))
        case 2:
            Group {
                AnyView(self[0].view(errorHandler: errorHandler?.in("0")))
                AnyView(self[1].view(errorHandler: errorHandler?.in("1")))
            }
        case 3:
            Group {
                AnyView(self[0].view(errorHandler: errorHandler?.in("0")))
                AnyView(self[1].view(errorHandler: errorHandler?.in("1")))
                AnyView(self[2].view(errorHandler: errorHandler?.in("2")))
            }
        case 4:
            Group {
                AnyView(self[0].view(errorHandler: errorHandler?.in("0")))
                AnyView(self[1].view(errorHandler: errorHandler?.in("1")))
                AnyView(self[2].view(errorHandler: errorHandler?.in("2")))
                AnyView(self[3].view(errorHandler: errorHandler?.in("3")))
            }
        case 5:
            Group {
                AnyView(self[0].view(errorHandler: errorHandler?.in("0")))
                AnyView(self[1].view(errorHandler: errorHandler?.in("1")))
                AnyView(self[2].view(errorHandler: errorHandler?.in("2")))
                AnyView(self[3].view(errorHandler: errorHandler?.in("3")))
                AnyView(self[4].view(errorHandler: errorHandler?.in("4")))
            }
        case 6:
            Group {
                AnyView(self[0].view(errorHandler: errorHandler?.in("0")))
                AnyView(self[1].view(errorHandler: errorHandler?.in("1")))
                AnyView(self[2].view(errorHandler: errorHandler?.in("2")))
                AnyView(self[3].view(errorHandler: errorHandler?.in("3")))
                AnyView(self[4].view(errorHandler: errorHandler?.in("4")))
                AnyView(self[5].view(errorHandler: errorHandler?.in("5")))
            }
        case 7:
            Group {
                AnyView(self[0].view(errorHandler: errorHandler?.in("0")))
                AnyView(self[1].view(errorHandler: errorHandler?.in("1")))
                AnyView(self[2].view(errorHandler: errorHandler?.in("2")))
                AnyView(self[3].view(errorHandler: errorHandler?.in("3")))
                AnyView(self[4].view(errorHandler: errorHandler?.in("4")))
                AnyView(self[5].view(errorHandler: errorHandler?.in("5")))
                AnyView(self[6].view(errorHandler: errorHandler?.in("6")))
            }
        case 8:
            Group {
                AnyView(self[0].view(errorHandler: errorHandler?.in("0")))
                AnyView(self[1].view(errorHandler: errorHandler?.in("1")))
                AnyView(self[2].view(errorHandler: errorHandler?.in("2")))
                AnyView(self[3].view(errorHandler: errorHandler?.in("3")))
                AnyView(self[4].view(errorHandler: errorHandler?.in("4")))
                AnyView(self[5].view(errorHandler: errorHandler?.in("5")))
                AnyView(self[6].view(errorHandler: errorHandler?.in("6")))
                AnyView(self[7].view(errorHandler: errorHandler?.in("7")))
            }
        case 9:
            Group {
                AnyView(self[0].view(errorHandler: errorHandler?.in("0")))
                AnyView(self[1].view(errorHandler: errorHandler?.in("1")))
                AnyView(self[2].view(errorHandler: errorHandler?.in("2")))
                AnyView(self[3].view(errorHandler: errorHandler?.in("3")))
                AnyView(self[4].view(errorHandler: errorHandler?.in("4")))
                AnyView(self[5].view(errorHandler: errorHandler?.in("5")))
                AnyView(self[6].view(errorHandler: errorHandler?.in("6")))
                AnyView(self[7].view(errorHandler: errorHandler?.in("7")))
                AnyView(self[8].view(errorHandler: errorHandler?.in("8")))
            }
        case 10:
            Group {
                AnyView(self[0].view(errorHandler: errorHandler?.in("0")))
                AnyView(self[1].view(errorHandler: errorHandler?.in("1")))
                AnyView(self[2].view(errorHandler: errorHandler?.in("2")))
                AnyView(self[3].view(errorHandler: errorHandler?.in("3")))
                AnyView(self[4].view(errorHandler: errorHandler?.in("4")))
                AnyView(self[5].view(errorHandler: errorHandler?.in("5")))
                AnyView(self[6].view(errorHandler: errorHandler?.in("6")))
                AnyView(self[7].view(errorHandler: errorHandler?.in("7")))
                AnyView(self[8].view(errorHandler: errorHandler?.in("8")))
                AnyView(self[9].view(errorHandler: errorHandler?.in("9")))
            }
        default:
            TooManyViewsView(count: count, errorHandler: errorHandler)
        }
    }
}

// Work around the fact that performing any side effects in the above containerView() func
// causes the Swift compiler to freak out
private struct TooManyViewsView: View {
    init(count: Int, errorHandler: ErrorHandler?) {
        errorHandler?.handle(JXError(message: "Too many views (\(count)) in content. Limit content to 10 views. Use nested 'Group' views to add more"))
    }
    
    var body: some View {
        return EmptyView()
    }
}

