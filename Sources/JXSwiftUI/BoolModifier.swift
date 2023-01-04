import JXKit

/// Protocol with default implementations for modifiers that accept a single bool argument.
protocol BoolModifier: SingleValueModifier where T == Bool {
}

extension BoolModifier {
    static func convert(_ value: JXValue) throws -> T {
        return value.isUndefined || value.bool
    }
}
