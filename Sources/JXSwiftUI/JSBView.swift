//
//  JSBView.swift
//
//  Created by Abe White on 9/29/22.
//

import JSBridge
import SwiftUI

/**
 A SwiftUI view that displays a view defined in JavaScript.
 */
public struct JSBView: View {
    private let _bridge: JSBridge?
    private let _context: JSBContext


    public init(bridge: JSBridge = JSBridge()) throws {
        _bridge = bridge
        _context = try bridge.newContext()
//        _context.importUI()
    }

    public init(context: JSBContext) throws {
        _bridge = nil
        _context = context
//        _context.importUI()
    }

    public var body: some View {
        // TODO: Implement
        EmptyView()
    }
}
