//
//  Frame.swift
//  swift-json-canvas
//

public struct Frame: Sendable, Equatable {
	public var x: Int
	public var y: Int
	public var width: Int
	public var height: Int

	public init(x: Int, y: Int, width: Int, height: Int) {
		self.x = x
		self.y = y
		self.width = width
		self.height = height
	}
}

public extension Node {
	var frame: Frame {
		Frame(x: x, y: y, width: width, height: height)
	}
}
