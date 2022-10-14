import SwiftUI

public protocol ButtonInfo: ScriptElementInfo {
    var contentInfo: ScriptElementInfo { get throws }
    func onAction() throws
}

/// A view whose body is a `SwiftUI.Button` view.
public struct ButtonView: View {
    private let _info: ButtonInfo

    public init(_ info: ButtonInfo) {
        _info = info
    }

    public var body: some View {
        Button(action: _onAction) {
            TypeSwitchView(_contentInfo)
        }
    }

    private var _contentInfo: ScriptElementInfo {
        do {
            return try _info.contentInfo
        } catch {
            // TODO: Error handling
            return EmptyElementInfo()
        }
    }

    private func _onAction() {
        do {
            try _info.onAction()
        } catch {
            // TODO: Error handling
        }
    }
}
