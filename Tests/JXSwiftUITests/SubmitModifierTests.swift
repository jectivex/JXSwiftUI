import JXBridge
import JXKit
@testable import JXSwiftUI
import XCTest

final class SubmitModifierTests: JXSwiftUITestsBase {
    func testDefaultTriggers() throws {
        let jxValue = try context.eval("jxswiftui.EmptyView().onSubmit(() => {})")
        let submit = try SubmitModifier(jxValue: jxValue)
        let _ = submit.view(errorHandler: errorHandler)
    }

    func testTriggers() throws {
        var jxValue = try context.eval("jxswiftui.EmptyView().onSubmit('search', () => {})")
        var submit = try SubmitModifier(jxValue: jxValue)
        let _ = submit.view(errorHandler: errorHandler)

        jxValue = try context.eval("jxswiftui.EmptyView().onSubmit(['text'], () => {})")
        submit = try SubmitModifier(jxValue: jxValue)
        let _ = submit.view(errorHandler: errorHandler)

        jxValue = try context.eval("jxswiftui.EmptyView().onSubmit(['text', 'search'], () => {})")
        submit = try SubmitModifier(jxValue: jxValue)
        let _ = submit.view(errorHandler: errorHandler)
    }
}
