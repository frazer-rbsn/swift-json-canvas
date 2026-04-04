//
//  Text.swift
//  swift-json-canvas
//

public struct TextNodeFragment: Sendable, Codable, Equatable {

	///
	/// The node text in plain text, in Markdown syntax.
	/// 
	public var text: String

	public init(text: String) {
		self.text = text
	}

	enum CodingKeys: CodingKey {
		case text
	}
}
