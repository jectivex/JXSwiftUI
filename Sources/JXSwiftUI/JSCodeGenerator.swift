import JXBridge

/// Generate supporting JavaScript code.
struct JSCodeGenerator {
    static let elementTypeProperty = "_jxswiftuiType"
    static let observerProperty = "_jxswiftuiObserver"
    static let stateProperty = "state"
    static let observedProperty = "observed"
    static let initStateFunction = "initState"
    static let bodyFunction = "body"
    static let withAnimationFunction = "withAnimation"
    static let willChangeFunction = "_jxswiftuiWillChange"
    
    static func initializationJS(namespace: JXNamespace) -> String {
        let js = """
\(namespace.value)._jxswiftuiStateHandler = {
    set(target, property, value) {
        if (property !== '_jxswiftuiObserver') {
            target.willChange();
        }
        target[property] = value;
        return true;
    }
}

\(namespace.value).JXElement = class {
    constructor(type) {
        this._jxswiftuiType = type;
    }

    font(fontName) {
        return \(namespace.value).\(ElementType.fontModifier.rawValue)(this, fontName);
    }

    navigationTitle(title) {
        return \(namespace.value).\(ElementType.navigationTitleModifier.rawValue)(this, title);
    }

    onTapGesture(action) {
        return \(namespace.value).\(ElementType.tapGestureModifier.rawValue)(this, action);
    }
}

\(namespace.value).JXView = class extends \(namespace.value).JXElement {
    constructor() {
        super('\(ElementType.custom.rawValue)');
        const state = {
            observed: {},
            willChange() {
                if (this._jxswiftuiObserver !== undefined && this._jxswiftuiObserver !== null) {
                    \(namespace.value)._jxswiftuiWillChange(this._jxswiftuiObserver);
                }
            }
        };
        state.o = state.observed;

        this.state = new Proxy(state, \(namespace.value)._jxswiftuiStateHandler);
        this.s = this.state;

        this.observed = {};
        this.o = this.observed;
    }

    initState() {
    }
}
"""
        print(js) //~~~
        return js
    }
    
    static func elementJS(for type: ElementType, namespace: JXNamespace) -> String? {
        guard let js = CustomInfo.infoType(for: type)?.js(namespace: namespace) else {
            return nil
        }
        let def = "\(namespace.value).\(type.rawValue) = \(js)"
        print(def) //~~~
        return def
    }
}
