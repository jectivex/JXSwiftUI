struct JSCodeGenerator {
    static let elementTypeProperty = "_jxuiType"
    static let observerProperty = "observer"
    static let bodyFunction = "body"
    
    static func defineUIFunctions() -> String {
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
        super('\(ElementType.custom.rawValue)');
        this.state = {}; // TODO: Use JS's Proxy to detect changes
        this.observer = null;
    }
}

function Button(actionOrLabel, actionOrContentFunction) {
    const e = new JXElement('\(ElementType.button.rawValue)');
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
    const e = new JXElement('\(ElementType.foreach.rawValue)');
    e.items = items;
    e.idFunction = idFunction;
    e.contentFunction = contentFunction;
    return e;
}

function HStack(content) {
    const e = new JXElement('\(ElementType.hstack.rawValue)');
    e.content = content;
    return e;
}

function If(isTrue, ifFunction, elseFunction=null) {
    const e = new JXElement('\(ElementType.if.rawValue)');
    e.isTrue = isTrue;
    e.ifFunction = ifFunction;
    e.elseFunction = elseFunction;
    return e;
}

function List(content) {
    const e = new JXElement('\(ElementType.list.rawValue)');
    e.content = content;
    return e;
}

function Spacer() {
    const e = new JXElement('\(ElementType.spacer.rawValue)');
    return e;
}

function Text(text) {
    const e = new JXElement('\(ElementType.text.rawValue)');
    e.text = text;
    return e;
}

function VStack(content) {
    const e = new JXElement('\(ElementType.vstack.rawValue)');
    e.content = content;
    return e;
}

// Modifiers

function FontModifier(target, fontName) {
    const e = new JXElement('\(ElementType.fontModifier.rawValue)');
    e.target = target;
    e.fontName = fontName;
    return e;
}

function TapGestureModifier(target, action) {
    const e = new JXElement('\(ElementType.tapGestureModifier.rawValue)');
    e.target = target;
    e.action = action;
    return e;
}
"""
    }
}
