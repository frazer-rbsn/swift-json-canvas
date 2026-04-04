//
//  EncodingTests.swift
//  swift-json-canvas
//

import Foundation
import JSONCanvas
import Testing

struct EnodingTests {
	let defaultID = UUID().uuidString
	let defaultFrame = Frame(x: 0, y: 0, width: 10, height: 10)
	let defaultColor = CanvasColor.preset(.orange)

	@Test func encodePresetColor() throws {
		let color = CanvasColor.preset(.orange)
		try #expect(encode(color) == "\"2\"")
	}

	@Test func encodeCustomColor() throws {
		let color = CanvasColor.custom("#FF0000")
		try #expect(encode(color) == "\"#FF0000\"")
	}

	@Test func encodeTextNode() throws {
		let text = "text"

		let node = Node.makeTextNode(id: defaultID,
		                             text: text,
		                             frame: defaultFrame,
		                             color: defaultColor)
		try encode(node)
	}

	@Test func encodeFileNode() throws {
		let file = "file"
		let subpath = "subpath"

		let node = Node.makeFileNode(id: defaultID,
		                             file: file,
		                             subpath: subpath,
		                             frame: defaultFrame,
		                             color: defaultColor)
		try encode(node)
	}

	@Test func encodeGroupNode() throws {
		let label = "label"
		let background = "background"
		let bgStyle: GroupNodeFragment.BackgroundStyle = .cover

		let node = Node.makeGroupNode(id: defaultID,
		                              label: label,
		                              background: background,
		                              backgroundStyle: bgStyle,
		                              frame: defaultFrame,
		                              color: defaultColor)
		try encode(node)
	}

	@Test func encodeLinkNode() throws {
		let link = "url"

		let node = Node.makeLinkNode(id: defaultID,
		                             url: link,
		                             frame: defaultFrame,
		                             color: defaultColor)
		try encode(node)
	}

	@Test func encodeEdge() throws {
		let edge = Edge(id: UUID().uuidString,
		                fromNode: UUID().uuidString,
		                fromSide: .left,
		                fromEnd: .none,
		                toNode: UUID().uuidString,
		                toSide: .right,
		                toEnd: .arrow,
		                color: .preset(.green),
		                label: "label")
		try encode(edge)
	}

	private func encode(_ encodable: some Encodable) throws -> String {
		let jsonEncoder = JSONEncoder()
		let data = try jsonEncoder.encode(encodable)
		let string = try #require(String(data: data, encoding: .utf8))
		print("Encoded object: \n\(encodable)\n")
		print(NSString(string: string))
		return string
	}
}
