//
//  NodeTests.swift
//  swift-json-canvas
//

import Foundation
import JSONCanvas
import Testing

struct NodeTests {

	let defaultID = UUID().uuidString
	let defaultFrame = Frame(x: 0, y: 0, width: 10, height: 10)
	let defaultColor = CanvasColor.preset(.orange)

	@Test func makeTextNode() throws {
		let text = "text"
		let node = Node.makeTextNode(id: defaultID, text: text, frame: defaultFrame, color: defaultColor)

		#expect(node.type == .text(.init(text: text)))
		#expect(node.frame == defaultFrame)
		#expect(node.id == defaultID)
		#expect(node.color == defaultColor)
	}

	@Test func makeGroupNode() throws {
		let label = "label"
		let background = "background"
		let bgStyle: GroupNodeFragment.BackgroundStyle = .cover
		let node = Node.makeGroupNode(id: defaultID,
		                              label: label,
		                              background: background,
		                              backgroundStyle: bgStyle,
		                              frame: defaultFrame,
		                              color: defaultColor)

		#expect(node.type == .group(.init(label: label, background: background, backgroundStyle: bgStyle)))
		#expect(node.frame == defaultFrame)
		#expect(node.id == defaultID)
		#expect(node.color == defaultColor)
	}

	@Test func makeFileNode() throws {
		let file = "file"
		let subpath = "subpath"
		let node = Node.makeFileNode(id: defaultID,
		                             file: file,
		                             subpath: subpath,
		                             frame: defaultFrame,
		                             color: defaultColor)

		#expect(node.type == .file(.init(file: file, subpath: subpath)))
		#expect(node.frame == defaultFrame)
		#expect(node.id == defaultID)
		#expect(node.color == defaultColor)
	}

	@Test func makeLinkNode() throws {
		let link = "url"
		let node = Node.makeLinkNode(id: defaultID, url: link, frame: defaultFrame, color: defaultColor)

		#expect(node.type == .link(.init(url: link)))
		#expect(node.frame == defaultFrame)
		#expect(node.id == defaultID)
		#expect(node.color == defaultColor)
	}
}
