import JXBridge

extension JXBridgeBuilder {
    /// Use this on your SwiftUI views to integrate them seamlessly into `JXSwiftUI`.
    public func asJXSwiftUIView() -> JXBridgeBuilder<T> {
        self.bridge.jsSuperclassName = JSCodeGenerator.elementClass
        return self
    }
}
