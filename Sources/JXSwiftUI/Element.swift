import JXBridge
import JXKit
import SwiftUI

/// Representation of a SwiftUI element.
protocol Element {
    var elementType: ElementType { get }
    func view(errorHandler: ErrorHandler?) -> any View
    static func js(namespace: JXNamespace) -> String?
    static func modifierJS(for modifier: String, namespace: JXNamespace) -> String?
}

extension Element {
    static func modifierJS(for modifier: String, namespace: JXNamespace) -> String? {
        return nil
    }
}

func elementStaticType(for type: ElementType) -> Element.Type? {
    switch type {
    case .button:
        return ButtonElement.self
    case .custom:
        return CustomElement.self
    case .empty:
        return EmptyElement.self
    case .foreach:
        return ForEachElement.self
    case .form:
        return FormElement.self
    case .hstack:
        return HStackElement.self
    case .if:
        return IfElement.self
    case .list:
        return ListElement.self
    case .native:
        return NativeElement.self
    case .navigationLink:
        return NavigationLinkElement.self
    case .navigationView:
        return NavigationViewElement.self
    case .section:
        return SectionElement.self
    case .spacer:
        return SpacerElement.self
    case .text:
        return TextElement.self
    case .vstack:
        return VStackElement.self
        
    case .fontModifier:
        return FontModifierElement.self
    case .navigationTitleModifier:
        return NavigationTitleModifierElement.self
    case .tapGestureModifier:
        return TapGestureModifierElement.self
    case .unknown:
        return nil
    }
}
    
func element(for jxValue: JXValue, type: ElementType) throws -> Element {
    switch type {
    case .button:
        return try ButtonElement(jxValue: jxValue)
    case .custom:
        return try CustomElement(jxValue: jxValue)
    case .empty:
        return EmptyElement()
    case .foreach:
        return try ForEachElement(jxValue: jxValue)
    case .form:
        return try FormElement(jxValue: jxValue)
    case .hstack:
        return try HStackElement(jxValue: jxValue)
    case .if:
        return try IfElement(jxValue: jxValue)
    case .list:
        return try ListElement(jxValue: jxValue)
    case .native:
        return try NativeElement(jxValue: jxValue)
    case .navigationLink:
        return try NavigationLinkElement(jxValue: jxValue)
    case .navigationView:
        return try NavigationViewElement(jxValue: jxValue)
    case .section:
        return try SectionElement(jxValue: jxValue)
    case .spacer:
        return try SpacerElement(jxValue: jxValue)
    case .text:
        return try TextElement(jxValue: jxValue)
    case .vstack:
        return try VStackElement(jxValue: jxValue)
        
    case .fontModifier:
        return try FontModifierElement(jxValue: jxValue)
    case .navigationTitleModifier:
        return try NavigationTitleModifierElement(jxValue: jxValue)
    case .tapGestureModifier:
        return try TapGestureModifierElement(jxValue: jxValue)
    case .unknown:
        throw JXError.internalError("Unknown JXSwiftUI element type")
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

