//
//  Group.swift
//  swift-json-canvas
//

public struct GroupNodeFragment: Sendable, Codable, Equatable {

	///
	/// A text label for the group.
	///
	public var label: String?

	///
	/// The path to the background image.
	///
	public var background: String?

	///
	/// The rendering style of the background image.
	///
	public var backgroundStyle: BackgroundStyle?

	public init(label: String? = nil, background: String? = nil, backgroundStyle: BackgroundStyle? = nil) {
		self.label = label
		self.background = background
		self.backgroundStyle = backgroundStyle
	}

	enum CodingKeys: CodingKey {
		case label
		case background
		case backgroundStyle
	}
}

public extension GroupNodeFragment {

	enum BackgroundStyle: String, Sendable, Codable, Equatable {

		///
		/// Fills the entire width and height of the node.
		///
		case cover

		///
		/// Maintains the aspect ratio of the background image.
		///
		case ratio

		///
		/// Repeats the image as a pattern in both x/y directions.
		///
		case `repeat`
	}
}
