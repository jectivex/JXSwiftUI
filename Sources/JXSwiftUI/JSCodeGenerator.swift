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
        return \(namespace.value).FontModifier(this, fontName);
    }

    onTapGesture(action) {
        return \(namespace.value).TapGestureModifier(this, action);
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
        guard let js = builtinElementJS(for: type, namespace: namespace) else {
            return nil
        }
        return defineSymbol(type.rawValue, namespace: namespace, as: js)
    }
    
    private static func builtinElementJS(for type: ElementType, namespace: JXNamespace) -> String? {
        switch type {
        case .button:
            return buttonJS(namespace: namespace)
        case .custom:
            return nil
        case .empty:
            return emptyJS(namespace: namespace)
        case .foreach:
            return forEachJS(namespace: namespace)
        case .hstack:
            return hstackJS(namespace: namespace)
        case .list:
            return listJS(namespace: namespace)
        case .if:
            return ifJS(namespace: namespace)
        case .spacer:
            return spacerJS(namespace: namespace)
        case .text:
            return textJS(namespace: namespace)
        case .vstack:
            return vstackJS(namespace: namespace)
        case .unknown:
            return nil
            
        case .fontModifier:
            return fontModifierJS(namespace: namespace)
        case .tapGestureModifier:
            return tapGestureModifierJS(namespace: namespace)
        }
    }
    
    private static func defineSymbol(_ symbol: String, namespace: JXNamespace, as definition: String) -> String {
        let js = "\(namespace.value).\(symbol) = \(definition)"
        print(js) //~~~
        return js
    }
    
    // MARK: Views
    
    private static func buttonJS(namespace: JXNamespace) -> String {
"""
function(actionOrLabel, actionOrContentFunction) {
    const e = new \(namespace.value).JXElement('\(ElementType.button.rawValue)');
    if (typeof(actionOrLabel) == 'string') {
        e.action = actionOrContentFunction;
        e.content = Text(actionOrLabel);
    } else {
        e.action = actionOrLabel;
        e.content = actionOrContentFunction();
    }
    return e;
}
"""
    }
    
    private static func emptyJS(namespace: JXNamespace) -> String {
"""
function() {
    return new \(namespace.value).JXElement('\(ElementType.empty.rawValue)');
}
"""
    }

    private static func forEachJS(namespace: JXNamespace) -> String {
        """
function(items, idFunction, contentFunction) {
    const e = new \(namespace.value).JXElement('\(ElementType.foreach.rawValue)');
    e.items = items;
    e.idFunction = idFunction;
    e.contentFunction = contentFunction;
    return e;
}
"""
    }

    private static func hstackJS(namespace: JXNamespace) -> String {
        """
function(content) {
    const e = new \(namespace.value).JXElement('\(ElementType.hstack.rawValue)');
    e.content = content;
    return e;
}
"""
    }

    private static func ifJS(namespace: JXNamespace) -> String {
        """
function(isTrue, ifFunction, elseFunction=null) {
    const e = new \(namespace.value).JXElement('\(ElementType.if.rawValue)');
    e.isTrue = isTrue;
    e.ifFunction = ifFunction;
    e.elseFunction = elseFunction;
    return e;
}
"""
}

    private static func listJS(namespace: JXNamespace) -> String {
        """
function(content) {
    const e = new \(namespace.value).JXElement('\(ElementType.list.rawValue)');
    e.content = content;
    return e;
}
"""
    }

    private static func spacerJS(namespace: JXNamespace) -> String {
        """
function() {
    const e = new \(namespace.value).JXElement('\(ElementType.spacer.rawValue)');
    return e;
}
"""
    }

    private static func textJS(namespace: JXNamespace) -> String {
        """
function(text) {
    const e = new \(namespace.value).JXElement('\(ElementType.text.rawValue)');
    e.text = text;
    return e;
}
"""
    }

    private static func vstackJS(namespace: JXNamespace) -> String {
        """
function(content) {
    const e = new \(namespace.value).JXElement('\(ElementType.vstack.rawValue)');
    e.content = content;
    return e;
}
"""
    }

    // MARK: Modifiers

    private static func fontModifierJS(namespace: JXNamespace) -> String {
        """
function(target, fontName) {
    const e = new \(namespace.value).JXElement('\(ElementType.fontModifier.rawValue)');
    e.target = target;
    e.fontName = fontName;
    return e;
}
"""
    }

    private static func tapGestureModifierJS(namespace: JXNamespace) -> String {
        """
function(target, action) {
    const e = new \(namespace.value).JXElement('\(ElementType.tapGestureModifier.rawValue)');
    e.target = target;
    e.action = action;
    return e;
}
"""
    }
}
