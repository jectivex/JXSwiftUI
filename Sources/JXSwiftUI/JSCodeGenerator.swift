import JXBridge

/// Generate supporting JavaScript code.
struct JSCodeGenerator {
    static let elementTypeProperty = "_jxswiftuiType"
    static let observerProperty = "_jxswiftuiObserver"
    static let stateProperty = "state"
    static let bodyFunction = "body"
    static let willChangeFunction = "_jxswiftuiWillChange"
    
    static func initializationJS(namespace: JXNamespace) -> String {
        let js = """
\(namespace.value)._jxswiftuiStateHandler = {
    set(target, property, value) {
        if (target._jxswiftuiObserver !== undefined && target._jxswiftuiObserver !== null) {
            \(namespace.value)._jxswiftuiWillChange(target._jxswiftuiObserver);
        }
        target[property] = value;
        return true;
    }
}

\(namespace.value).JXElement = class {
    _jxswiftuiType;

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
    state;

    constructor() {
        super('\(ElementType.custom.rawValue)');
        this.state = new Proxy({}, \(namespace.value)._jxswiftuiStateHandler);
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
