# JXSwiftUI

[![Build Status][GitHubActionBadge]][ActionsLink]
[![Swift5 compatible][Swift5Badge]][Swift5Link] 
![Platform][SwiftPlatforms]

Build SwiftUI user interfaces in JavaScript using `JXKit`.

## API

Browse the [API Documentation].

## Dependencies

- [JXKit][]: Cross-platform JavaScript engine[^1]
- [JXBridge][]: Bridge native types to JavaScript[^2]

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
- Observe published values from JS.
- Bindings.
- Allow JS views to pass JS content views to custom native container views.
- Supply context and error handler to downstream native views that want to bridge back to JavaScript with a `JXView`.
    - Wrapped in a single JXSwiftUIContext object?
    - As environment values? Or harden and use JXKit's "current" context stack?
