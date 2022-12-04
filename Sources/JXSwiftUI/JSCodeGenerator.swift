import JXBridge

/// Generate supporting JavaScript code.
struct JSCodeGenerator {
    static let elementClass = "JXElement"
    static let stateProperty = "state"
    static let observedProperty = "observed"
    static let initStateFunction = "initState"
    static let bodyFunction = "body"
    static let withAnimationFunction = "withAnimation"
    static let bindingClass = "_jxswiftuiBinding"
    static let elementTypeProperty = "_jxswiftuiType"
    static let observerProperty = "_jxswiftuiObserver"
    static let willChangeFunction = "_jxswiftuiWillChange"
    static let addModifierFunction = "_jxswiftuiAddModifier"
    
    static func initializationJS(namespace: JXNamespace) -> String {
        let js = """
\(namespace.value)._jxswiftuiStateHandler = {
    get(target, property, receiver) {
        if (target[property] === undefined) {
            if (property.startsWith('$')) {
                const stateProperty = property.slice(1);
                return new \(namespace.value)._jxswiftuiBinding(() => {
                    return target[stateProperty];
                }, (value) => {
                    target.willChange();
                    target[stateProperty] = value;
                })
            }
            return undefined;
        }
        return target[property];
    },
    set(target, property, value) {
        if (!property.startsWith('_jxswiftui')) {
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
        return target[property];
    }
}
\(namespace.value)._jxswiftuiBindingHandler = {
    get(target, property, receiver) {
        const binding = target[property];
        if (binding === undefined) {
            return undefined;
        }
        return binding.get();
    },
    set(target, property, value) {
        if (value.constructor.name === '_jxswiftuiBinding') {
            target[property] = value;
            return true;
        }
        const binding = target[property];
        if (binding === undefined) {
            return false;
        }
        binding.set(value);
        return true;
    }
}
\(namespace.value)._jxswiftuiBinding = class {
    constructor(get, set) {
        this.get = get;
        this.set = set;
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
        }
        this.state = new Proxy(state, \(namespace.value)._jxswiftuiStateHandler);
        this.binding = new Proxy({}, \(namespace.value)._jxswiftuiBindingHandler);
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
