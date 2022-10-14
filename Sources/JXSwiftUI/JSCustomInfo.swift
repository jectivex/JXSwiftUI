//
//  JSCustomInfo.swift
//
//  Created by Abe White on 9/26/22.
//

import Combine
import JXKit
import ScriptUI
import SwiftUI

// TODO: Temporarily public for testing in PlaygroundApp
public struct JSCustomInfo: CustomInfo {
    private let _jxValue: JXValue
    private let _observer = JSUIObserver()

    public init(jxValue: JXValue) throws {
        _jxValue = jxValue
        let observerValue = jxValue.env.object(peer: _observer)
        try jxValue.setProperty(CodeGenerator.observerProperty, observerValue)
    }

    public var elementType: ScriptElementType {
        return .custom
    }

    public var onChange: AnyPublisher<Void, Never> {
        return _observer.objectWillChange.eraseToAnyPublisher()
    }

    public var contentInfo: ScriptElementInfo {
        get throws {
            let bodyValue = try _jxValue.invokeMethod(CodeGenerator.bodyFunction, withArguments: [])
            let className = try _jxValue["constructor"]["name"].stringValue
            return try JXElementInfo.content(for: bodyValue, in: className)
        }
    }
}
