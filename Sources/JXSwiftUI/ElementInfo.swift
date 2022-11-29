import JXBridge
import JXKit
import SwiftUI

typealias ErrorHandler = (Error) -> Void

/// Information from the script's representation of a UI element.
protocol ElementInfo {
    var elementType: ElementType { get }
    func view(errorHandler: ErrorHandler?) -> any View
    static func js(namespace: JXNamespace) -> String?
}

extension ElementInfo {
    static func infoType(for elementType: ElementType) -> ElementInfo.Type? {
        switch elementType {
        case .button:
            return ButtonInfo.self
        case .custom:
            return CustomInfo.self
        case .empty:
            return EmptyInfo.self
        case .foreach:
            return ForEachInfo.self
        case .hstack:
            return HStackInfo.self
        case .if:
            return IfInfo.self
        case .list:
            return ListInfo.self
        case .native:
            return NativeInfo.self
        case .navigationLink:
            return NavigationLinkInfo.self
        case .navigationView:
            return NavigationViewInfo.self
        case .spacer:
            return SpacerInfo.self
        case .text:
            return TextInfo.self
        case .vstack:
            return VStackInfo.self

        case .fontModifier:
            return FontModifierInfo.self
        case .navigationTitleModifier:
            return NavigationTitleModifierInfo.self
        case .tapGestureModifier:
            return TapGestureModifierInfo.self
        case .unknown:
            return nil
        }
    }
    
    static func info(for jxValue: JXValue, in elementType: ElementType) throws -> ElementInfo {
        return try info(for: jxValue, in: elementType.rawValue)
    }
    
    static func info(for jxValue: JXValue, in elementName: String) throws -> ElementInfo {
        guard !jxValue.isUndefined else {
            throw JXSwiftUIErrors.undefinedValue(elementName)
        }
        
        let elementType: ElementType
        if jxValue.hasProperty(JSCodeGenerator.elementTypeProperty) {
            let elementTypeString = try jxValue[JSCodeGenerator.elementTypeProperty].string
            elementType = ElementType(rawValue: elementTypeString) ?? .unknown
        } else {
            elementType = .native
        }
        switch elementType {
        case .button:
            return try ButtonInfo(jxValue: jxValue)
        case .custom:
            return try CustomInfo(jxValue: jxValue)
        case .empty:
            return EmptyInfo()
        case .foreach:
            return try ForEachInfo(jxValue: jxValue)
        case .hstack:
            return try HStackInfo(jxValue: jxValue)
        case .if:
            return try IfInfo(jxValue: jxValue)
        case .list:
            return try ListInfo(jxValue: jxValue)
        case .native:
            return try NativeInfo(jxValue: jxValue)
        case .navigationLink:
            return try NavigationLinkInfo(jxValue: jxValue)
        case .navigationView:
            return try NavigationViewInfo(jxValue: jxValue)
        case .spacer:
            return try SpacerInfo(jxValue: jxValue)
        case .text:
            return try TextInfo(jxValue: jxValue)
        case .vstack:
            return try VStackInfo(jxValue: jxValue)

        case .fontModifier:
            return try FontModifierInfo(jxValue: jxValue)
        case .navigationTitleModifier:
            return try NavigationTitleModifierInfo(jxValue: jxValue)
        case .tapGestureModifier:
            return try TapGestureModifierInfo(jxValue: jxValue)
        case .unknown:
            throw JXSwiftUIErrors.unknownValue(elementName, try jxValue.string)
        }
    }

    static func infoArray(for jxValue: JXValue, in elementType: ElementType) throws -> [ElementInfo] {
        return try infoArray(for: jxValue, in: elementType.rawValue)
    }
    
    static func infoArray(for jxValue: JXValue, in elementName: String) throws -> [ElementInfo] {
        guard !jxValue.isUndefined else {
            throw JXSwiftUIErrors.undefinedValue(elementName)
        }
        guard jxValue.isArray else {
            throw JXSwiftUIErrors.valueNotArray(elementName, try jxValue.string)
        }
        let contentArray = try jxValue.array
        return try (0 ..< contentArray.count).map { i in
            return try info(for: contentArray[i], in: elementName)
        }
    }
}

extension Array where Element == ElementInfo {
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

