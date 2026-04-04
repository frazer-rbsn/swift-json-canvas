//
//  CanvasTests.swift
//  swift-json-canvas
//

import Foundation
import Testing
import JSONCanvas

struct CanvasTests {

	@Test func initEmptyCanvas() {
		let canvas = Canvas()
		#expect(canvas.nodes.isEmpty)
		#expect(canvas.edges.isEmpty)
	}
}
