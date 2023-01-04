import JXBridge
import JXKit
@testable import JXSwiftUI
import XCTest

final class ListStyleModifierTests: JXSwiftUITestsBase {
    func testListStyleModifier() throws {
        let sampleStyles = ["automatic", "plain", "sidebar"]
        for style in sampleStyles {
            try listStyleTest(style)
        }
    }

#if os(macOS)
    func testAlternatingBackground() throws {
        var jxValue = try context.eval("jxswiftui.EmptyView().listStyle('inset', {alternatesRowBackgrounds: true})")
        var listStyle = try ListStyleModifier(jxValue: jxValue)
        let _ = listStyle.view(errorHandler: errorHandler)

        jxValue = try context.eval("jxswiftui.EmptyView().listStyle('inset', {})")
        listStyle = try ListStyleModifier(jxValue: jxValue)
        let _ = listStyle.view(errorHandler: errorHandler)
    }
#endif

    func listStyleTest(_ style: String) throws {
        let jxValue = try context.eval("jxswiftui.EmptyView().listStyle('\(style)')")
        let listStyle = try ListStyleModifier(jxValue: jxValue)
        let _ = listStyle.view(errorHandler: errorHandler)
    }
}
