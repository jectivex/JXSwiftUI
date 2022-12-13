import JXBridge
import JXKit
import SwiftUI

extension JXSwiftUISupport {
    /// Sets a foreground color on a target view.
    /// 
    /// Supported calls:
    ///
    ///     - .foregroundColor('name')
    ///     - .foregroundColor(Color)
    public enum foregroundColor {}
}

struct ForegroundColorModifier: Element {
    private let target: Content
    private let color: Color
    
    init(jxValue: JXValue) throws {
        self.target = try Content(jxValue: jxValue["target"])
        let colorValue = try jxValue["color"]
        if colorValue.isString {
            self.color = try Color(colorValue.string)
        } else {
            self.color = try colorValue.convey()
        }
    }

    func view(errorHandler: ErrorHandler?) -> any View {
        return target.element(errorHandler: errorHandler)
            .view(errorHandler: errorHandler)
            .foregroundColor(color)
    }
    
    static func modifierJS(namespace: JXNamespace) -> String? {
        // .foregroundColor(Color) or .foregroundColor('name')
        return """
function(color) {
    const e = new \(JXNamespace.default).\(JSCodeGenerator.elementClass)('\(ElementType.foregroundColorModifier.rawValue)');
    e.target = this;
    e.color = color;
    return e;
}
"""
    }
}
