//
//  Canvas.swift
//  swift-json-canvas
//

import IdentifiedCollections

public typealias ID = String

///
/// The top-level object. An infinite canvas of nodes and edges.
///
/// To edit the canvas, you may modify the properties directly.
/// For example, to add a node:
/// ```
/// let textNode = Node.makeTextNode(
///   text: text,
///   frame: .init(x: 0, y: 0, width: 100, height: 100),
///   color: .preset(.orange)
/// )
///
/// canvas.nodes.append(textNode)
/// ```
///
public struct Canvas {
	public var nodes: IdentifiedArrayOf<Node>
	public var edges: IdentifiedArrayOf<Edge>

	///
	/// Initialises an empty canvas.
	///
	public init() {
		nodes = []
		edges = []
	}

	public init(nodes: IdentifiedArrayOf<Node>, edges: IdentifiedArrayOf<Edge>) {
		self.nodes = nodes
		self.edges = edges
	}
}

extension Canvas: Codable {
	public init(from decoder: any Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		nodes = try container.decodeIfPresent(IdentifiedArrayOf<Node>.self, forKey: .nodes) ?? []
		edges = try container.decodeIfPresent(IdentifiedArrayOf<Edge>.self, forKey: .edges) ?? []
	}
}
