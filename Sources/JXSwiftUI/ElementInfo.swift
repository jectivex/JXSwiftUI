import JXKit
import SwiftUI

typealias ErrorHandler = (Error) -> Void

/// Information from the script's representation of a UI element.
protocol ElementInfo {
    var elementType: ElementType { get }
    func view(errorHandler: ErrorHandler?) -> TypeSwitchView
}

extension ElementInfo {
    func view(errorHandler: ErrorHandler?) -> TypeSwitchView {
        return TypeSwitchView(info: self, errorHandler: errorHandler)
    }

    static func `for`(_ jxValue: JXValue) throws -> ElementInfo? {
        let elementTypeString = try jxValue[JSCodeGenerator.elementTypeProperty].string
        let elementType = ElementType(rawValue: elementTypeString) ?? .unknown
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
        guard let elementInfo = try self.for(jxValue) else {
            throw JXSwiftUIErrors.unknownValue(elementName, try jxValue.string)
        }
        return elementInfo
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
            self[0].view(errorHandler: errorHandler)
        case 2:
            Group {
                self[0].view(errorHandler: errorHandler)
                self[1].view(errorHandler: errorHandler)
            }
        case 3:
            Group {
                self[0].view(errorHandler: errorHandler)
                self[1].view(errorHandler: errorHandler)
                self[2].view(errorHandler: errorHandler)
            }
        case 4:
            Group {
                self[0].view(errorHandler: errorHandler)
                self[1].view(errorHandler: errorHandler)
                self[2].view(errorHandler: errorHandler)
                self[3].view(errorHandler: errorHandler)
            }
        case 5:
            Group {
                self[0].view(errorHandler: errorHandler)
                self[1].view(errorHandler: errorHandler)
                self[2].view(errorHandler: errorHandler)
                self[3].view(errorHandler: errorHandler)
                self[4].view(errorHandler: errorHandler)
            }
        case 6:
            Group {
                self[0].view(errorHandler: errorHandler)
                self[1].view(errorHandler: errorHandler)
                self[2].view(errorHandler: errorHandler)
                self[3].view(errorHandler: errorHandler)
                self[4].view(errorHandler: errorHandler)
                self[5].view(errorHandler: errorHandler)
            }
        case 7:
            Group {
                self[0].view(errorHandler: errorHandler)
                self[1].view(errorHandler: errorHandler)
                self[2].view(errorHandler: errorHandler)
                self[3].view(errorHandler: errorHandler)
                self[4].view(errorHandler: errorHandler)
                self[5].view(errorHandler: errorHandler)
                self[6].view(errorHandler: errorHandler)
            }
        case 8:
            Group {
                self[0].view(errorHandler: errorHandler)
                self[1].view(errorHandler: errorHandler)
                self[2].view(errorHandler: errorHandler)
                self[3].view(errorHandler: errorHandler)
                self[4].view(errorHandler: errorHandler)
                self[5].view(errorHandler: errorHandler)
                self[6].view(errorHandler: errorHandler)
                self[7].view(errorHandler: errorHandler)
            }
        case 9:
            Group {
                self[0].view(errorHandler: errorHandler)
                self[1].view(errorHandler: errorHandler)
                self[2].view(errorHandler: errorHandler)
                self[3].view(errorHandler: errorHandler)
                self[4].view(errorHandler: errorHandler)
                self[5].view(errorHandler: errorHandler)
                self[6].view(errorHandler: errorHandler)
                self[7].view(errorHandler: errorHandler)
                self[8].view(errorHandler: errorHandler)
            }
        case 10:
            Group {
                self[0].view(errorHandler: errorHandler)
                self[1].view(errorHandler: errorHandler)
                self[2].view(errorHandler: errorHandler)
                self[3].view(errorHandler: errorHandler)
                self[4].view(errorHandler: errorHandler)
                self[5].view(errorHandler: errorHandler)
                self[6].view(errorHandler: errorHandler)
                self[7].view(errorHandler: errorHandler)
                self[8].view(errorHandler: errorHandler)
                self[9].view(errorHandler: errorHandler)
            }
        default:
            EmptyView()
        }
    }
}

