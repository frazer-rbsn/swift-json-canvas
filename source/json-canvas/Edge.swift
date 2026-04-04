//
//  Edge.swift
//  swift-json-canvas
//

///
/// A line that connects one node to another.
///
public struct Edge: Sendable, Identifiable {

	///
	/// A unique ID for the edge.
	///
	public let id: ID

	///
	/// The node ID where the connection starts.
	///
	public var fromNode: Node.ID

	///
	/// The side where this edge starts.
	///
	public var fromSide: Side?


	///
	/// The shape of the endpoint at the edge start
	///
	public var fromEnd: End

	///
	/// The node id where the connection ends.
	///
	public var toNode: Node.ID

	///
	/// The side where this edge ends.
	///
	public var toSide: Side?

	///
	/// The shape of the endpoint at the edge end.
	///
	public var toEnd: End

	///
	/// The colour of the line.
	///
	public var color: CanvasColor?

	///
	/// A text label for the edge.
	///
	public var label: String?

	public init(id: ID,
							fromNode: Node.ID,
							fromSide: Side? = nil,
							fromEnd: End,
							toNode: Node.ID,
							toSide: Side? = nil,
							toEnd: End,
							color: CanvasColor? = nil,
							label: String? = nil) {
		self.id = id
		self.fromNode = fromNode
		self.fromSide = fromSide
		self.fromEnd = fromEnd
		self.toNode = toNode
		self.toSide = toSide
		self.toEnd = toEnd
		self.color = color
		self.label = label
	}
}

extension Edge: Codable {
	public init(from decoder: any Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		self.id = try container.decode(ID.self, forKey: .id)
		self.fromNode = try container.decode(Node.ID.self, forKey: .fromNode)
		self.fromSide = try container.decodeIfPresent(Side.self, forKey: .fromSide)
		self.fromEnd = try container.decodeIfPresent(End.self, forKey: .fromEnd) ?? .none
		self.toNode = try container.decode(Node.ID.self, forKey: .toNode)
		self.toSide = try container.decodeIfPresent(Side.self, forKey: .toSide)
		self.toEnd = try container.decodeIfPresent(End.self, forKey: .toEnd) ?? .arrow
		self.color = try container.decodeIfPresent(CanvasColor.self, forKey: .color)
		self.label = try container.decodeIfPresent(String.self, forKey: .label)
	}
}

public enum Side: String, Sendable, Codable {
	case top
	case right
	case bottom
	case left
}

public enum End: String, Sendable, Codable {
	case none
	case arrow
}
