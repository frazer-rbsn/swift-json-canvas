//
//  Node.swift
//  swift-json-canvas
//

import Foundation

///
/// An object within the canvas.
///
/// Nodes may be text, files, links, or groups.
/// Nodes are placed in the array in ascending order by z-index.
/// The first node in the array should be displayed below all other nodes, and the last node in the array
/// should be displayed on top of all other nodes.
///
/// To generate a new node, use the factory functions, such as ``makeTextNode(id:text:frame:color:)``.
///
public struct Node: Sendable, Identifiable {

	///
	/// A unique ID for the node.
	///
	public let id: ID

	///
	/// The node type.
	///
	public var type: NodeType

	///
	/// The x position of the node in pixels. May be positive or negative.
	///
	public var x: Int

	///
	/// The y position of the node in pixels.
	///
	public var y: Int

	///
	/// The width of the node in pixels.
	///
	public var width: Int

	///
	/// The height of the node in pixels.
	///
	public var height: Int

	///
	/// The colour of the node.
	///
	public var color: CanvasColor?

	private init(id: ID,
	             type: NodeType,
	             x: Int,
	             y: Int,
	             width: Int,
	             height: Int,
	             color: CanvasColor?) {
		self.id = id
		self.type = type
		self.x = x
		self.y = y
		self.width = width
		self.height = height
		self.color = color
	}

	private init(id: ID, type: NodeType, frame: Frame, color: CanvasColor?) {
		self.init(id: id,
		          type: type,
		          x: frame.x,
		          y: frame.y,
		          width: frame.width,
		          height: frame.height,
		          color: color)
	}
}

// MARK: - Codable implementation

extension Node: Codable {

	public init(from decoder: any Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		id = try container.decode(ID.self, forKey: .id)
		type = try NodeType(from: decoder)
		x = try container.decode(Int.self, forKey: .x)
		y = try container.decode(Int.self, forKey: .y)
		width = try container.decode(Int.self, forKey: .width)
		height = try container.decode(Int.self, forKey: .height)
		color = try container.decodeIfPresent(CanvasColor.self, forKey: .color) ?? nil
	}

	public func encode(to encoder: any Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		try container.encode(id, forKey: .id)
		try type.encode(to: encoder)
		try container.encode(x, forKey: .x)
		try container.encode(y, forKey: .y)
		try container.encode(width, forKey: .width)
		try container.encode(height, forKey: .height)
		try container.encodeIfPresent(color, forKey: .color)
	}

	enum CodingKeys: CodingKey {
		case id
		case type
		case x
		case y
		case width
		case height
		case color
	}
}

// MARK: - Factory funcs

public extension Node {

	static func makeTextNode(id: Node.ID = UUID().uuidString,
	                         text: String,
	                         frame: Frame,
	                         color: CanvasColor? = nil) -> Self {
		Node(id: id, type: .text(.init(text: text)), frame: frame, color: color)
	}

	static func makeFileNode(id: Node.ID = UUID().uuidString,
	                         file: String,
	                         subpath: String? = nil,
	                         frame: Frame,
	                         color: CanvasColor? = nil) -> Self {
		Node(id: id, type: .file(.init(file: file, subpath: subpath)), frame: frame, color: color)
	}

	static func makeGroupNode(id: Node.ID = UUID().uuidString,
	                          label: String? = nil,
	                          background: String? = nil,
	                          backgroundStyle: GroupNodeFragment.BackgroundStyle? = nil,
	                          frame: Frame,
	                          color: CanvasColor? = nil) -> Self {
		Node(id: id,
		     type: .group(.init(label: label,
		                        background: background,
		                        backgroundStyle: backgroundStyle)),
		     frame: frame, color: color)
	}

	static func makeLinkNode(id: Node.ID = UUID().uuidString,
	                         url: String,
	                         frame: Frame,
	                         color: CanvasColor? = nil) -> Self {
		Node(id: id, type: .link(.init(url: url)), frame: frame, color: color)
	}
}
