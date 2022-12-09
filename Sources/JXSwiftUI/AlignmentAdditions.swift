import SwiftUI

/// - Note: In the future we might consider bridging `Alignment` or expanding support, but for now a simple `RawRepresentable` feels sufficient for most use cases
extension Alignment: RawRepresentable {
    public init?(rawValue: String) {
        switch rawValue {
        case "topLeading":
            self = .topLeading
        case "top":
            self = .top
        case "topTrailing":
            self = .topTrailing
        case "leading":
            self = .leading
        case "center":
            self = .center
        case "trailing":
            self = .trailing
        case "bottomLeading":
            self = .bottomLeading
        case "bottom":
            self = .bottom
        case "bottomTrailing":
            self = .bottomTrailing
        case "leadingFirstTextBaseline":
            self = .leadingFirstTextBaseline
        case "centerFirstTextBaseline":
            self = .centerFirstTextBaseline
        case "trailingFirstTextBaseline":
            self = .trailingFirstTextBaseline
        case "leadingLastTextBaseline":
            self = .leadingLastTextBaseline
        case "centerLastTextBaseline":
            self = .centerLastTextBaseline
        case "trailingLastTextBaseline":
            self = .centerLastTextBaseline
        default:
            return nil
        }
    }
    
    public var rawValue: String {
        switch self {
        case .topLeading:
            return "topLeading"
        case .top:
            return "top"
        case .topTrailing:
            return "topTrailing"
        case .leading:
            return "leading"
        case .center:
            return "center"
        case .trailing:
            return "trailing"
        case .bottomLeading:
            return "bottomLeading"
        case .bottom:
            return "bottom"
        case .bottomTrailing:
            return "bottomTrailing"
        case .leadingFirstTextBaseline:
            return "leadingFirstTextBaseline"
        case .centerFirstTextBaseline:
            return "centerFirstTextBaseline"
        case .trailingFirstTextBaseline:
            return "trailingFirstTextBaseline"
        case .leadingLastTextBaseline:
            return "leadingLastTextBaseline"
        case .centerLastTextBaseline:
            return "centerLastTextBaseline"
        case .trailingLastTextBaseline:
            return "centerLastTextBaseline"
        default:
            return "unknown"
        }
    }
}

/// - Note: In the future we might consider bridging `HorizontalAlignment` or expanding support, but for now a simple `RawRepresentable` feels sufficient for most use cases
extension HorizontalAlignment: RawRepresentable {
    public init?(rawValue: String) {
        switch rawValue {
        case "center":
            self = .center
        case "leading":
            self = .leading
        case "trailing":
            self = .trailing
        default:
            if #available(iOS 16.0, *) {
                if rawValue == "listRowSeparatorLeading" {
                    self = .listRowSeparatorLeading
                } else if rawValue == "listRowSeparatorTrailing" {
                    self = .listRowSeparatorTrailing
                }
            }
            return nil
        }
    }
    
    public var rawValue: String {
        switch self {
        case .center:
            return "center"
        case .leading:
            return "leading"
        case.trailing:
            return "trailing"
        default:
            if #available(iOS 16.0, *) {
                if self == .listRowSeparatorLeading {
                    return "listRowSeparatorLeading"
                } else if self == .listRowSeparatorTrailing {
                    return "listRowSeparatorTrailing"
                }
            }
            return "unknown"
        }
    }
}

/// - Note: In the future we might consider bridging `VerticalAlignment` or expanding support, but for now a simple `RawRepresentable` feels sufficient for most use cases
extension VerticalAlignment: RawRepresentable {
    public init?(rawValue: String) {
        switch rawValue {
        case "center":
            self = .center
        case "top":
            self = .top
        case "bottom":
            self = .bottom
        case "firstTextBaseline":
            self = .firstTextBaseline
        case "lastTextBaseline":
            self = .lastTextBaseline
        default:
            return nil
        }
    }
    
    public var rawValue: String {
        switch self {
        case .center:
            return "center"
        case .top:
            return "top"
        case .bottom:
            return "bottom"
        case .firstTextBaseline:
            return "firstTextBaseline"
        case .lastTextBaseline:
            return "lastTextBaseline"
        default:
            return "unknown"
        }
    }
}
