PolymorphCore
=================================

[![Swift Version](https://img.shields.io/badge/swift-4.2-orange.svg?style=flat)](https://developer.apple.com/swift/)
[![Swift Package Manager](https://rawgit.com/jlyonsmith/artwork/master/SwiftPackageManager/swiftpackagemanager-compatible.svg)](https://swift.org/package-manager/)
[![Twitter](https://img.shields.io/badge/twitter-@Digipolitan-blue.svg?style=flat)](http://twitter.com/Digipolitan)

Core models to the [PolymorphCore](https://github.com/Digipolitan/polymorph-cli) project

## Installation

### SPM

To install PolymorphCore with SwiftPackageManager, add the following lines to your `Package.swift`.

```swift
let package = Package(
    name: "XXX",
    products: [
        .library(
            name: "XXX",
            targets: ["XXX"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Digipolitan/polymorph-core.git", from: "1.1.0")
    ],
    targets: [
        .target(
            name: "XXX",
            dependencies: ["PolymorphCore"])
    ]
)
```

## The Basics

```swift
guard let package = try? Package(string: "com.digipolitan.sample"),
      let userPackage = try? Package(string: "user") else {
    return
}
let project = Project(name: "Sample", package: package)
project.models.addClass(.init(name: "User", package: userPackage))

let encoder = JSONEncoder()
if let data = try? encoder.encode(project),
    let json = String(data: data, encoding: .utf8) {
    print(json) // Print project as JSON
}
```

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for more details!

This project adheres to the [Contributor Covenant Code of Conduct](CODE_OF_CONDUCT.md).
By participating, you are expected to uphold this code. Please report
unacceptable behavior to [contact@digipolitan.com](mailto:contact@digipolitan.com).

## License

PolymorphCore is licensed under the [BSD 3-Clause license](LICENSE).
