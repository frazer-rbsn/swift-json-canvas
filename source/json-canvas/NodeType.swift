//
//  NodeType.swift
//  swift-json-canvas
//

public enum NodeType: Sendable, Equatable {

	///
	/// Text type nodes store text.
	///
	case text(TextNodeFragment)

	///
	/// File type nodes reference other files or attachments, such as images, videos, etc.
	///
	case file(FileNodeFragment)

	///
	/// Link type nodes reference a URL.
	///
	case link(LinkNodeFragment)

	///
	/// Group type nodes are used as a visual container for nodes within it.
	///
	case group(GroupNodeFragment)
}

private enum NodeTypeKey: String, Codable {
	case text
	case file
	case link
	case group
}

extension NodeType: Codable {

	public init(from decoder: any Decoder) throws {
		let container = try decoder.container(keyedBy: Node.CodingKeys.self)
		let type = try container.decode(NodeTypeKey.self, forKey: .type)

		self = switch type {
			case .text: .text(try TextNodeFragment(from: decoder))
			case .file: .file(try FileNodeFragment(from: decoder))
			case .link: .link(try LinkNodeFragment(from: decoder))
			case .group: .group(try GroupNodeFragment(from: decoder))
		}
	}

	public func encode(to encoder: any Encoder) throws {
		var typeContainer = encoder.container(keyedBy: Node.CodingKeys.self)

		switch self {
			case let .text(textNode):
				try typeContainer.encode("text", forKey: .type)
				var textContainer = encoder.container(keyedBy: TextNodeFragment.CodingKeys.self)
				try textContainer.encode(textNode.text, forKey: .text)
			case let .file(fileNode):
				try typeContainer.encode("file", forKey: .type)
				var fileContainer = encoder.container(keyedBy: FileNodeFragment.CodingKeys.self)
				try fileContainer.encode(fileNode.file, forKey: .file)
				try fileContainer.encodeIfPresent(fileNode.subpath, forKey: .subpath)
			case let .link(link):
				try typeContainer.encode("link", forKey: .type)
				var linkContainer = encoder.container(keyedBy: LinkNodeFragment.CodingKeys.self)
				try linkContainer.encode(link.url, forKey: .url)
			case let .group(group):
				try typeContainer.encode("group", forKey: .type)
				var groupContainer = encoder.container(keyedBy: GroupNodeFragment.CodingKeys.self)
				try groupContainer.encodeIfPresent(group.label, forKey: .label)
				try groupContainer.encodeIfPresent(group.background, forKey: .background)
				try groupContainer.encodeIfPresent(group.backgroundStyle, forKey: .backgroundStyle)
		}
	}
}
