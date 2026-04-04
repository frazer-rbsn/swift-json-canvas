//
//  File.swift
//  swift-json-canvas
//

public struct FileNodeFragment: Sendable, Codable, Equatable {

	///
	/// The path to the file within the system.
	///
	public var file: String

	///
	/// A subpath that may link to a heading or a block. Always starts with a #.
	/// 
	public var subpath: String?

	public init(file: String, subpath: String? = nil) {
		self.file = file
		self.subpath = subpath
	}

	public enum CodingKeys: CodingKey {
		case file
		case subpath
	}
}
