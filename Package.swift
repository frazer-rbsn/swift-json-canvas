//swift-tools-version:5.10

import PackageDescription

let package = Package(
	name: "swift-json-canvas",
	platforms: [
		.macOS(.v14),
		.iOS(.v17),
	],
	products: [
		.library(
			name: "JSONCanvas",
			targets: ["JSONCanvas"]
		),
	],
	dependencies: [
		.package(url: "https://github.com/pointfreeco/swift-identified-collections", exact: "1.1.1")
	],
	targets: [
		.target(
			name: "JSONCanvas",
			dependencies: [.product(name: "IdentifiedCollections", package: "swift-identified-collections")],
			path: "source/"
		),
		.testTarget(
			name: "JSONCanvasTests",
			dependencies: ["JSONCanvas"],
			path: "test/"
		),
	]
)
