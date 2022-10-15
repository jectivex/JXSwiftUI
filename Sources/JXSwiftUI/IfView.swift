import SwiftUI

protocol IfInfo: ElementInfo {
    var isTrue: Bool { get throws }
    var ifContentInfo: ElementInfo { get throws }
    var elseContentInfo: ElementInfo? { get throws }
}

/// A view that includes 'if' or 'else' content depending on a boolean condition.
struct IfView: View {
    private let info: IfInfo

    init(_ info: IfInfo) {
        self.info = info
    }

    var body: some View {
        if isTrue {
            ifContentInfo.view
        } else if let elseContentInfo = self.elseContentInfo {
            elseContentInfo.view
        }
    }

    private var isTrue: Bool {
        do {
            return try info.isTrue
        } catch {
            // TODO: Error handling
            return false
        }
    }

    private var ifContentInfo: ElementInfo {
        do {
            return try info.ifContentInfo
        } catch {
            // TODO: Error handling
            return EmptyInfo()
        }
    }

    private var elseContentInfo: ElementInfo? {
        do {
            return try info.elseContentInfo
        } catch {
            // TODO: Error handling
            return nil
        }
    }
}
