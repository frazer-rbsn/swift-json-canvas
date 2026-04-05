# swift-json-canvas
[JSON Canvas](https://jsoncanvas.org), for Swift.

[![macOS](https://github.com/frazer-rbsn/swift-json-canvas/actions/workflows/macos.yml/badge.svg)](https://github.com/frazer-rbsn/swift-json-canvas/actions/workflows/macos.yml)

* Supports decoding and encoding via `Codable`
* Uses structs for performance
* Uses [Point-Free's `IdentifiedArray`](https://github.com/pointfreeco/swift-identified-collections) for the `nodes` and `edges` arrays, for easy fetching and modification.


## Installation

Swift Package Manager:

```swift
dependencies: [
  .package(url: "https://github.com/frazer-rbsn/swift-json-canvas", exact: "0.0.1"),
],
```


## Usage

```swift
// Initialising a new canvas and adding nodes
var canvas = Canvas()
let node = Node.makeTextNode(text: text, frame: .init(x: 0, y: 0, width: 0, height: 0), color: .preset(.red))
canvas.nodes.append(node)

// Decoding a canvas
let decoder = JSONDecoder()
let data = yourJsonCanvasString.data(using: .utf8)!
let canvas = try decoder.decode(Canvas.self, from: data)
```

Coded by hand.
