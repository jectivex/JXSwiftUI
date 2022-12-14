import JXBridge

/// Generate supporting JavaScript code.
struct JSCodeGenerator {
    static let stateProperty = "state"
    static let observedProperty = "observed"
    static let initStateFunction = "initState"
    static let bodyFunction = "body"
    static let withAnimationFunction = "withAnimation"
    static let elementClass = "_jxswiftuiElement" // Note: this is in the global namespace. See JXBridgeBuilderAdditions
    static let bindingClass = "_jxswiftuiBinding" // Note: this is in the global namespace so that we can convey it
    static let elementTypeProperty = "_jxswiftuiType"
    static let observerProperty = "_jxswiftuiObserver"
    static let willChangeFunction = "_jxswiftuiWillChange"
    static let addModifierFunction = "_jxswiftuiAddModifier"
    
    static func initializationJS(namespace: JXNamespace) -> String {
        let js = """
_jxswiftuiElement = class {
    constructor(type) {
        this._jxswiftuiType = (type === undefined) ? '\(ElementType.native.rawValue)' : type;
        return new Proxy(this, \(namespace)._jxswiftuiElementHandler);
    }
}
_jxswiftuiBinding = class {
    constructor(get, set) {
        this.get = get;
        this.set = set;
    }
}
\(namespace)._jxswiftuiStateHandler = {
    get(target, property, receiver) {
        if (target[property] === undefined) {
            if (property.startsWith('$')) {
                const stateProperty = property.slice(1);
                return new _jxswiftuiBinding(() => {
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
\(namespace)._jxswiftuiElementHandler = {
    get(target, property, receiver) {
        if (target[property] === undefined) {
            \(namespace)._jxswiftuiAddModifier(property);
        }
        return target[property];
    }
}
\(namespace)._jxswiftuiBindingHandler = {
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
\(namespace).JXView = class extends _jxswiftuiElement {
    constructor() {
        super('\(ElementType.custom.rawValue)');
        const state = {
            willChange() {
                if (this._jxswiftuiObserver !== undefined && this._jxswiftuiObserver !== null) {
                    \(namespace)._jxswiftuiWillChange(this._jxswiftuiObserver);
                }
            }
        }
        this.state = new Proxy(state, \(namespace)._jxswiftuiStateHandler);
        this.binding = new Proxy({}, \(namespace)._jxswiftuiBindingHandler);
        this.observed = {};
    }

    initState() {
    }
}
"""
        //print(js)
        return js
    }
    
    static func elementJS(for type: ElementType, namespace: JXNamespace) -> String? {
        guard let js = type.valueType?.js(namespace: namespace) else {
            return nil
        }
        let def = "\(namespace).\(type.rawValue) = \(js)"
        //print(def)
        return def
    }
    
    static func modifierJS(for type: ElementType, modifier: String, namespace: JXNamespace) -> String? {
        guard let js = type.valueType?.modifierJS(namespace: namespace) else {
            return nil
        }
        let def = "\(elementClass).prototype.\(modifier) = \(js)"
        //print(def)
        return def
    }
}
