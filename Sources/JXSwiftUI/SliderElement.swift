import JXBridge
import JXKit
import SwiftUI

extension JXSwiftUISupport {
    /// A `SwiftUI.Slider`.
    ///
    /// Supported usage:
    ///
    ///     - Slider($value)
    ///     - Slider($value, 'label')
    ///     - Slider($value, {props})
    ///     - Slider($value, {props}, content)
    ///
    /// Supported `value`:
    ///
    ///     - `Binding` to a Double
    ///
    /// Supported `props`:
    ///
    ///     - label: Content
    ///     - minimumValueLabel: Content
    ///     - maximumValueLabel: Content
    ///     - minimumValue: Number
    ///     - maximumValue: Number
    ///     - step: Number
    ///
    /// Supported `content`:
    ///
    ///     - Label string
    ///     - View
    ///     - Anonymous function returning a View
    public enum Slider {}
}

struct SliderElement: Element {
    private let value: Binding<Double>
    private let minimumValue: Double
    private let maximumValue: Double
    private let step: Double?
    private let label: Content?
    private let minimumValueLabel: Content?
    private let maximumValueLabel: Content?

    init(jxValue: JXValue) throws {
        self.value = try jxValue["value"].convey()
        let propsValue = try jxValue["props"]
        if propsValue.isUndefined {
            self.minimumValue = 0.0
            self.maximumValue = 1.0
            self.step = nil
            self.label = nil
            self.minimumValueLabel = nil
            self.maximumValueLabel = nil
        } else if propsValue.isString {
            self.minimumValue = 0.0
            self.maximumValue = 1.0
            self.step = nil
            self.label = try Content(jxValue: propsValue)
            self.minimumValueLabel = nil
            self.maximumValueLabel = nil
        } else {
            let minimumValue = try propsValue["minimumValue"]
            self.minimumValue = try minimumValue.isUndefined ? 0.0 : minimumValue.double
            let maximumValue = try propsValue["maximumValue"]
            self.maximumValue = try maximumValue.isUndefined ? 0.0 : maximumValue.double
            let stepValue = try propsValue["step"]
            self.step = try stepValue.isUndefined ? nil : stepValue.double
            
            let contentValue = try jxValue["content"]
            if contentValue.isUndefined {
                self.label = try Content.optional(jxValue: propsValue["label"])
            } else {
                self.label = try Content(jxValue: contentValue)
            }
            self.minimumValueLabel = try Content.optional(jxValue: propsValue["minimumValueLabel"])
            self.maximumValueLabel = try Content.optional(jxValue: propsValue["minimumValueLabel"])
        }
    }

    func view(errorHandler: ErrorHandler) -> any View {
        let errorHandler = errorHandler.in(.slider)
        // Is there any way to support cases with or without a step without repeating all code?
        if let step {
            return Slider(value: value, in: minimumValue...maximumValue, step: step) {
                if let label = self.label {
                    let labelErrorHandler = errorHandler.attr("label")
                    label.element(errorHandler: labelErrorHandler)
                        .view(errorHandler: labelErrorHandler)
                        .eraseToAnyView()
                } else {
                    EmptyView()
                }
            } minimumValueLabel: {
                if let minimumValueLabel {
                    let labelErrorHandler = errorHandler.attr("minimumValueLabel")
                    minimumValueLabel.element(errorHandler: labelErrorHandler)
                        .view(errorHandler: labelErrorHandler)
                        .eraseToAnyView()
                } else {
                    EmptyView()
                }
            } maximumValueLabel: {
                if let maximumValueLabel {
                    let labelErrorHandler = errorHandler.attr("maximumValueLabel")
                    maximumValueLabel.element(errorHandler: labelErrorHandler)
                        .view(errorHandler: labelErrorHandler)
                        .eraseToAnyView()
                } else {
                    EmptyView()
                }
            }
        } else {
            return Slider(value: value, in: minimumValue...maximumValue) {
                if let label {
                    let labelErrorHandler = errorHandler.attr("label")
                    label.element(errorHandler: labelErrorHandler)
                        .view(errorHandler: labelErrorHandler)
                        .eraseToAnyView()
                } else {
                    EmptyView()
                }
            } minimumValueLabel: {
                if let minimumValueLabel {
                    let labelErrorHandler = errorHandler.attr("minimumValueLabel")
                    minimumValueLabel.element(errorHandler: labelErrorHandler)
                        .view(errorHandler: labelErrorHandler)
                        .eraseToAnyView()
                } else {
                    EmptyView()
                }
            } maximumValueLabel: {
                if let maximumValueLabel {
                    let labelErrorHandler = errorHandler.attr("maximumValueLabel")
                    maximumValueLabel.element(errorHandler: labelErrorHandler)
                        .view(errorHandler: labelErrorHandler)
                        .eraseToAnyView()
                } else {
                    EmptyView()
                }
            }
        }
    }
    
    static func js(namespace: JXNamespace) -> String? {
"""
function(value, props, content) {
    const e = new \(JSCodeGenerator.elementClass)('\(ElementType.slider.rawValue)');
    e.value = value;
    e.props = props;
    e.content = content;
    return e;
}
"""
    }
}

