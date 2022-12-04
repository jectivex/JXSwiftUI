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
            AnyView(self[0].view(errorHandler: errorHandler))
        case 2:
            Group {
                AnyView(self[0].view(errorHandler: errorHandler))
                AnyView(self[1].view(errorHandler: errorHandler))
            }
        case 3:
            Group {
                AnyView(self[0].view(errorHandler: errorHandler))
                AnyView(self[1].view(errorHandler: errorHandler))
                AnyView(self[2].view(errorHandler: errorHandler))
            }
        case 4:
            Group {
                AnyView(self[0].view(errorHandler: errorHandler))
                AnyView(self[1].view(errorHandler: errorHandler))
                AnyView(self[2].view(errorHandler: errorHandler))
                AnyView(self[3].view(errorHandler: errorHandler))
            }
        case 5:
            Group {
                AnyView(self[0].view(errorHandler: errorHandler))
                AnyView(self[1].view(errorHandler: errorHandler))
                AnyView(self[2].view(errorHandler: errorHandler))
                AnyView(self[3].view(errorHandler: errorHandler))
                AnyView(self[4].view(errorHandler: errorHandler))
            }
        case 6:
            Group {
                AnyView(self[0].view(errorHandler: errorHandler))
                AnyView(self[1].view(errorHandler: errorHandler))
                AnyView(self[2].view(errorHandler: errorHandler))
                AnyView(self[3].view(errorHandler: errorHandler))
                AnyView(self[4].view(errorHandler: errorHandler))
                AnyView(self[5].view(errorHandler: errorHandler))
            }
        case 7:
            Group {
                AnyView(self[0].view(errorHandler: errorHandler))
                AnyView(self[1].view(errorHandler: errorHandler))
                AnyView(self[2].view(errorHandler: errorHandler))
                AnyView(self[3].view(errorHandler: errorHandler))
                AnyView(self[4].view(errorHandler: errorHandler))
                AnyView(self[5].view(errorHandler: errorHandler))
                AnyView(self[6].view(errorHandler: errorHandler))
            }
        case 8:
            Group {
                AnyView(self[0].view(errorHandler: errorHandler))
                AnyView(self[1].view(errorHandler: errorHandler))
                AnyView(self[2].view(errorHandler: errorHandler))
                AnyView(self[3].view(errorHandler: errorHandler))
                AnyView(self[4].view(errorHandler: errorHandler))
                AnyView(self[5].view(errorHandler: errorHandler))
                AnyView(self[6].view(errorHandler: errorHandler))
                AnyView(self[7].view(errorHandler: errorHandler))
            }
        case 9:
            Group {
                AnyView(self[0].view(errorHandler: errorHandler))
                AnyView(self[1].view(errorHandler: errorHandler))
                AnyView(self[2].view(errorHandler: errorHandler))
                AnyView(self[3].view(errorHandler: errorHandler))
                AnyView(self[4].view(errorHandler: errorHandler))
                AnyView(self[5].view(errorHandler: errorHandler))
                AnyView(self[6].view(errorHandler: errorHandler))
                AnyView(self[7].view(errorHandler: errorHandler))
                AnyView(self[8].view(errorHandler: errorHandler))
            }
        case 10:
            Group {
                AnyView(self[0].view(errorHandler: errorHandler))
                AnyView(self[1].view(errorHandler: errorHandler))
                AnyView(self[2].view(errorHandler: errorHandler))
                AnyView(self[3].view(errorHandler: errorHandler))
                AnyView(self[4].view(errorHandler: errorHandler))
                AnyView(self[5].view(errorHandler: errorHandler))
                AnyView(self[6].view(errorHandler: errorHandler))
                AnyView(self[7].view(errorHandler: errorHandler))
                AnyView(self[8].view(errorHandler: errorHandler))
                AnyView(self[9].view(errorHandler: errorHandler))
            }
        default:
            EmptyView()
        }
    }
}

