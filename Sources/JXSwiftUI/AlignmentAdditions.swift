import SwiftUI

extension JXSwiftUISupport {
    /// Use a JavaScript string to name any standard `SwiftUI.Alignment` value, e.g. `'topLeading'`.
    public enum Alignment {}
    
    /// Use a JavaScript string to name any standard `SwiftUI.HorizontalAlignment` value, e.g. `'leading'`.
    public enum HorizontalAlignment {}
    
    /// Use a JavaScript string to name any standard `SwiftUI.VerticalAlignment` value, e.g. `'top'`.
    public enum VerticalAlignment {}
}

/// Represent each standard `SwiftUI.Alignment` value as a JavaScript string.
///
/// - Note: In the future we might consider promoting `Alignment` to a full type.
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
#if !os(macOS)
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
#endif
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
#if !os(macOS)
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
#endif
        default:
            return "unknown"
        }
    }
}

/// Represent each standard `SwiftUI.HorizontalAlignment` value as a JavaScript string.
///
/// - Note: In the future we might consider promoting `HorizontalAlignment` to a full type.
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
#if !os(macOS)
            if #available(iOS 16.0, *) {
                if rawValue == "listRowSeparatorLeading" {
                    self = .listRowSeparatorLeading
                } else if rawValue == "listRowSeparatorTrailing" {
                    self = .listRowSeparatorTrailing
                }
            }
#endif
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
#if !os(macOS)
            if #available(iOS 16.0, *) {
                if self == .listRowSeparatorLeading {
                    return "listRowSeparatorLeading"
                } else if self == .listRowSeparatorTrailing {
                    return "listRowSeparatorTrailing"
                }
            }
#endif
            return "unknown"
        }
    }
}

/// Represent each standard `SwiftUI.VerticalAlignment` value as a JavaScript string.
///
/// - Note: In the future we might consider promoting `VerticalAlignment` to a full type.
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
