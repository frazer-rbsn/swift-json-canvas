//
//  DecodingTests.swift
//  swift-json-canvas
//

import Foundation
import Testing
import JSONCanvas

struct DecodingTests {

	@Test func decodeJsonCanvasOrgSample() async throws {
		let decoder = JSONDecoder()
		let data = try #require(jsonCanvasOrgSample.data(using: .utf8))
		let canvas = try decoder.decode(Canvas.self, from: data)

		#expect(canvas.nodes.count == 6)

		let node1 = try #require(canvas.nodes.first)
		#expect(node1.id == "754a8ef995f366bc")

		if case let .group(groupFragment) = node1.type {
			#expect(groupFragment.label == "JSON Canvas")
		} else {
			Issue.record("Expected group type, but found \(node1.type) instead.")
		}

		#expect(node1.x == -300)
		#expect(node1.y == -460)
		#expect(node1.width == 610)
		#expect(node1.height == 200)

		let node2 = canvas.nodes[1]
		#expect(node2.id == "8132d4d894c80022")

		if case let .file(fileFragment) = node2.type {
			#expect(fileFragment.file == "readme.md")
		} else {
			Issue.record("Expected group type, but found \(node2.type) instead.")
		}

		#expect(node2.color == .preset(.purple))

		let node4 = canvas.nodes[3]

		if case let .text(textFragment) = node4.type {
			#expect(textFragment.text == "Learn more:\n\n- [Apps](/docs/apps.md)\n- [Spec](spec/1.0.md)\n- [Github](https://github.com/obsidianmd/jsoncanvas)")
		} else {
			Issue.record("Expected text type, but found \(node4.type) instead.")
		}
	}

}

let jsonCanvasOrgSample = #"""
{
 "nodes":[
	{"id":"754a8ef995f366bc","type":"group","x":-300,"y":-460,"width":610,"height":200,"label":"JSON Canvas"},
	{"id":"8132d4d894c80022","type":"file","file":"readme.md","x":-280,"y":-200,"width":570,"height":560,"color":"6"},
	{"id":"7efdbbe0c4742315","type":"file","file":"_site/logo.svg","x":-280,"y":-440,"width":217,"height":80},
	{"id":"59e896bc8da20699","type":"text","text":"Learn more:\n\n- [Apps](/docs/apps.md)\n- [Spec](spec/1.0.md)\n- [Github](https://github.com/obsidianmd/jsoncanvas)","x":40,"y":-440,"width":250,"height":160},
	{"id":"0ba565e7f30e0652","type":"file","file":"spec/1.0.md","x":360,"y":-400,"width":400,"height":400},
	{"id": "01KNCNKDA0FCQYQ9WF93Q0GH6T","x": -114,"y": -192,"color": "#02b94e","width": 232,"height": 309,"type": "link","url": "https://jsoncanvas.org/spec/1.0"},
 ],
 "edges":[
	{"id":"6fa11ab87f90b8af","fromNode":"7efdbbe0c4742315","fromSide":"right","toNode":"59e896bc8da20699","toSide":"left"}
 ]
}
"""#

