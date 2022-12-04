import JXBridge

/// Generate supporting JavaScript code.
struct JSCodeGenerator {
    static let elementClass = "JXElement"
    static let elementTypeProperty = "_jxswiftuiType"
    static let observerProperty = "_jxswiftuiObserver"
    static let stateProperty = "state"
    static let observedProperty = "observed"
    static let initStateFunction = "initState"
    static let bodyFunction = "body"
    static let withAnimationFunction = "withAnimation"
    static let willChangeFunction = "_jxswiftuiWillChange"
    static let addModifierFunction = "_jxswiftuiAddModifier"
    
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
\(namespace.value)._jxswiftuiElementHandler = {
    get(target, property, receiver) {
        if (target[property] === undefined) {
            \(namespace.value)._jxswiftuiAddModifier(property);
        }
        return target[property]
    }
}

\(namespace.value).JXElement = class {
    constructor(type) {
        this._jxswiftuiType = type;
        return new Proxy(this, \(namespace.value)._jxswiftuiElementHandler);
    }
}

\(namespace.value).JXView = class extends \(namespace.value).JXElement {
    constructor() {
        super('\(ElementType.custom.rawValue)');
        const state = {
            willChange() {
                if (this._jxswiftuiObserver !== undefined && this._jxswiftuiObserver !== null) {
                    \(namespace.value)._jxswiftuiWillChange(this._jxswiftuiObserver);
                }
            }
        };
        this.state = new Proxy(state, \(namespace.value)._jxswiftuiStateHandler);
        this.observed = {};
    }

    initState() {
    }
}
"""
        print(js) //~~~
        return js
    }
    
    static func elementJS(for type: ElementType, namespace: JXNamespace) -> String? {
        guard let js = elementStaticType(for: type)?.js(namespace: namespace) else {
            return nil
        }
        let def = "\(namespace.value).\(type.rawValue) = \(js)"
        print(def) //~~~
        return def
    }
    
    static func modifierJS(for type: ElementType, modifier: String, namespace: JXNamespace) -> String? {
        guard let js = elementStaticType(for: type)?.modifierJS(for: modifier, namespace: namespace) else {
            return nil
        }
        let def = "\(namespace.value).\(elementClass).prototype.\(modifier) = \(js)"
        print(def) //~~~
        return def
    }
}
