import SwiftUI

protocol NavigationTitleModifierInfo: ElementInfo {
    var targetInfo: ElementInfo { get throws }
    var title: String { get throws }
}

/// A view that specifies a navigation title forr its target view.
struct NavigationTitleModifierView: View {
    let info: NavigationTitleModifierInfo
    let errorHandler: ErrorHandler?

    var body: some View {
        targetInfo.view(errorHandler: errorHandler)
            .navigationTitle(title)
    }

    private var targetInfo: ElementInfo {
        do {
            return try info.targetInfo
        } catch {
            errorHandler?(error)
            return EmptyInfo()
        }
    }

    private var title: String {
        do {
            return try info.title
        } catch {
            errorHandler?(error)
            return ""
        }
    }
}
