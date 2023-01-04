# JXSwiftUI

[![Build Status][GitHubActionBadge]][ActionsLink]
[![Swift5 compatible][Swift5Badge]][Swift5Link] 
![Platform][SwiftPlatforms]

Build SwiftUI user interfaces in JavaScript using `JXKit`.

## API

Browse the [API Documentation].

## Dependencies

- [JXKit][]: Cross-platform JavaScript engine
- [JXBridge][]: Bridge native types to JavaScript

[Swift Package Manager]: https://swift.org/package-manager
[API Documentation]: https://www.jective.org/JXSwiftUI/documentation/jxswiftui/

[ProjectLink]: https://github.com/jectivex/JXSwiftUI
[ActionsLink]: https://github.com/jectivex/JXSwiftUI/actions
[API Documentation]: https://www.jective.org/JXSwiftUI/documentation/jxswiftui/

[Swift]: https://swift.org/
[JXKit]: https://github.com/jectivex/JXKit
[JXBridge]: https://github.com/jectivex/JXBridge
[JavaScriptCore]: https://trac.webkit.org/wiki/JavaScriptCore

[GitHubActionBadge]: https://img.shields.io/github/workflow/status/jectivex/JXSwiftUI/JXSwiftUI%20CI

[Swift5Badge]: https://img.shields.io/badge/swift-5-orange.svg?style=flat
[Swift5Link]: https://developer.apple.com/swift/
[SwiftPlatforms]: https://img.shields.io/badge/Platforms-macOS%20|%20iOS%20|%20tvOS%20|%20Linux-teal.svg

## TODO

- Support more standard views and modifiers.
- ObservableObject equivalent for JS model objects.
- Test Bindings.
    - Pass JS state var to other JS view as binding.
    - Pass JS state var to native view as binding.
- Allow JS views to pass JS content views to custom native container views.
- JS support for checking platform (iOS vs. macOS, etc).
- String localization.
- Custom color, image, and resource loading plugins.
- Performance testing and optimizations.
- Support .modifier() and pluggable modifier types and functions.
- Previews integration.
