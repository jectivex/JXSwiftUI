import JXKit

extension JXContext {
    // TODO: Create general import mechanism in JXKit
    public func importSwiftUI() throws {
        guard !global.hasProperty("_jxuiWillChange") else {
            return
        }

        let willChangeFunction = JXValue(newFunctionIn: self) { jxContext, this, args in
            guard args.count == 1 else {
                // TODO: error
                return jxContext.undefined()
            }
            let observerValue = args[0]
            if let observer = observerValue.peer as? JXUIObserver {
                observer.willChange()
            }
            return jxContext.undefined()
        }
        try global.setProperty("_jxuiWillChange", willChangeFunction)

        let uiCode = JSCodeGenerator.defineUIFunctions()
        try eval(uiCode)
    }
}
