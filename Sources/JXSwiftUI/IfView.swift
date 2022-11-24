import SwiftUI

protocol IfInfo: ElementInfo {
    var isTrue: Bool { get throws }
    var ifContentInfo: ElementInfo { get throws }
    var elseContentInfo: ElementInfo? { get throws }
}

/// A view that includes 'if' or 'else' content depending on a boolean condition.
struct IfView: View {
    let info: IfInfo
    let errorHandler: ErrorHandler?

    var body: some View {
        if isTrue {
            ifContentInfo.view(errorHandler: errorHandler)
        } else if let elseContentInfo = self.elseContentInfo {
            elseContentInfo.view(errorHandler: errorHandler)
        }
    }

    private var isTrue: Bool {
        do {
            return try info.isTrue
        } catch {
            errorHandler?(error)
            return false
        }
    }

    private var ifContentInfo: ElementInfo {
        do {
            return try info.ifContentInfo
        } catch {
            errorHandler?(error)
            return EmptyInfo()
        }
    }

    private var elseContentInfo: ElementInfo? {
        do {
            return try info.elseContentInfo
        } catch {
            errorHandler?(error)
            return nil
        }
    }
}
