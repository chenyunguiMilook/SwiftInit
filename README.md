# SwiftInit

**SwiftInit**: A lightweight Swift library that dynamically generates executable initialization code for `SourceInitable`( classes with ease.

## Overview

swiftInit simplifies the process of converting Swift classes into initialization code. By implementing the `SourceInitable` protocol, your classes can dynamically produce instantiation statements tailored to their properties, making debugging, testing, and code generation a breeze.

## Installation

### Swift Package Manager

Add SwiftInit to your project via Swift Package Manager by including it in your `Package.swift` file:

```swift
dependencies: [
    .package(url: "https://github.com/chenyunguiMilook/SwiftInit.git", from: "0.1")
]
```

Then, add it to your target:

```swift
.target(name: "YourTarget", dependencies: ["SwiftInit"])
```

## Usage

SwiftInit works with any class or struct that conforms to the `SourceInitable` protocol. Here's an example using `CGPoint`:


```swift
import SwiftInit

extension CGPoint: SourceInitable {
    public func source() -> Initializer {
        .object(Self.self) {
            Parameter("x", self.x)
            Parameter("y", self.y)
        }
    }
}

// Example usage
let point = CGPoint(x: 10, y: 20)
let initializer = point.source()
print(initializer) // Outputs: CGPoint(x: 10, y: 20)
```

In this example, `CGPoint` implements `SourceInitable` to generate an `Initializer` object representing its initialization code. You can copy this output and use it directly in your Swift code.

### Key Features
- Generate initialization code dynamically based on object properties.
- Supports custom parameter logic for flexible instantiation.
- Lightweight and easy to integrate into any Swift project.

## Contributing

Contributions are welcome! Feel free to submit issues, feature requests, or pull requests via the [GitHub repository](https://github.com/chenyunguiMilook/SwiftInit).

1. Fork the repository.
2. Create your feature branch (`git checkout -b feature/AmazingFeature`).
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`).
4. Push to the branch (`git push origin feature/AmazingFeature`).
5. Open a pull request.

## License

SwiftInit is released under the MIT License. See [LICENSE](LICENSE) for details.
