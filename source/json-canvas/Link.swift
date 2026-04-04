//
//  Link.swift
//  swift-json-canvas
//

public struct LinkNodeFragment: Sendable, Codable, Equatable {
	public var url: String

	public init(url: String) {
		self.url = url
	}

	public enum CodingKeys: CodingKey {
		case url
	}
}
