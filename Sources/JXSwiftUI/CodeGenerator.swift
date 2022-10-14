import JXKit // TODO: Temporary for testing

// TODO: Temporarily public for testing in PlaygroundApp
public struct CodeGenerator {
    static let elementTypeProperty = "_jxuiType"
    static let observerProperty = "observer"
    static let bodyFunction = "body"

    // TODO: Temporarily here for testing
    public static func defineInitialFunctions(in jxContext: JXContext) throws {
        let willChangeFunction = JXValue(newFunctionIn: jxContext) { jxContext, this, args in
            guard args.count == 1 else {
                // TODO: error
                return jxContext.undefined()
            }
            let observerValue = args[0]
            if let observer = observerValue.peer as? JSUIObserver {
                observer.willChange()
            }
            return jxContext.undefined()
        }
        try jxContext.global.setProperty("_jxuiWillChange", willChangeFunction)
    }
    
    public static func defineUIFunctions() -> String {
        return """
class JXElement {
    _jxuiType;

    constructor(type) {
        this._jxuiType = type;
    }

    font(fontName) {
        return FontModifier(this, fontName);
    }

    onTapGesture(action) {
        return TapGestureModifier(this, action);
    }
}

class JXView extends JXElement {
    state;
    observer; // TODO: Make this auto-triggered by any 'state' change

    constructor() {
        super('\(ScriptElementType.custom.rawValue)');
        this.state = {}; // TODO: Use JS's Proxy to detect changes
        this.observer = null;
    }
}

function Button(actionOrLabel, actionOrContentFunction) {
    const e = new JXElement('\(ScriptElementType.button.rawValue)');
    if (typeof(actionOrLabel) == 'string') {
        e.action = actionOrContentFunction;
        e.content = Text(actionOrLabel);
    } else {
        e.action = actionOrLabel;
        e.content = actionOrContentFunction();
    }
    return e;
}

function ForEach(items, idFunction, contentFunction) {
    const e = new JXElement('\(ScriptElementType.foreach.rawValue)');
    e.items = items;
    e.idFunction = idFunction;
    e.contentFunction = contentFunction;
    return e;
}

function HStack(content) {
    const e = new JXElement('\(ScriptElementType.hstack.rawValue)');
    e.content = content;
    return e;
}

function If(isTrue, ifFunction, elseFunction=null) {
    const e = new JXElement('\(ScriptElementType.if.rawValue)');
    e.isTrue = isTrue;
    e.ifFunction = ifFunction;
    e.elseFunction = elseFunction;
    return e;
}

function List(content) {
    const e = new JXElement('\(ScriptElementType.list.rawValue)');
    e.content = content;
    return e;
}

function Spacer() {
    const e = new JXElement('\(ScriptElementType.spacer.rawValue)');
    return e;
}

function Text(text) {
    const e = new JXElement('\(ScriptElementType.text.rawValue)');
    e.text = text;
    return e;
}

function VStack(content) {
    const e = new JXElement('\(ScriptElementType.vstack.rawValue)');
    e.content = content;
    return e;
}

// Modifiers

function FontModifier(target, fontName) {
    const e = new JXElement('\(ScriptElementType.fontModifier.rawValue)');
    e.target = target;
    e.fontName = fontName;
    return e;
}

function TapGestureModifier(target, action) {
    const e = new JXElement('\(ScriptElementType.tapGestureModifier.rawValue)');
    e.target = target;
    e.action = action;
    return e;
}
"""
    }
}
