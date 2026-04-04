//
//  Color.swift
//  swift-json-canvas
//

import Foundation

///
/// Used to encode colour data for nodes and edges.
///
/// Color attributes expect a string.
/// They can be specified in hex format e.g. "#FF0000", or using one of the preset colors, e.g. "1" for red.
///
public enum CanvasColor: Sendable, Equatable {
	case preset(Preset)
	case custom(String)
}

public extension CanvasColor {
	enum Preset: Int, Sendable {
		case red = 1
		case orange
		case yellow
		case green
		case cyan
		case purple
	}
}

extension CanvasColor: Codable {
	public init(from decoder: any Decoder) throws {
		let container = try decoder.singleValueContainer()
		let value = try container.decode(String.self)

		if value.hasPrefix("#") {
			self = .custom(value)
		} else {
			guard let intValue = Int(value), let preset = Preset(rawValue: intValue) else {
				throw DecodingError.invalidPresetValue(value)
			}
			self = .preset(preset)
		}
	}

	public func encode(to encoder: any Encoder) throws {
		var container = encoder.singleValueContainer()
		switch self {
			case let .preset(presetColor):
				try container.encode("\(presetColor.rawValue)")
			case let .custom(hex):
				try container.encode(hex)
		}
	}

	enum DecodingError: LocalizedError {
		case invalidPresetValue(String)
	}
}
