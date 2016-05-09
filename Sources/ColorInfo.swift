//
//  ColorInfo.swift
//
// Copyright (c) 2016 Netguru Sp. z o.o. All rights reserved.
// Licensed under the MIT License.
//

public struct ColorInfo: APIRepresentationConvertible {

	let color: Color
	let score: Double
	let pixelFraction: Double

	public enum Error: ErrorType {

		case InvalidScore
		case InvalidPixelFraction
	}

	public init(color: Color, score: Double, pixelFraction: Double) throws {
		guard 0...1 ~= score else {
			throw Error.InvalidScore
		}
		guard 0...1 ~= pixelFraction else {
			throw Error.InvalidPixelFraction
		}
		self.color = color
		self.score = score
		self.pixelFraction = pixelFraction
	}

	public init(APIRepresentationValue value: APIRepresentationValue) throws {
		try self.init(
			color: value.get("color"),
			score: value.get("score"),
			pixelFraction: value.get("pixelFraction")
		)
	}
}
// MARK: -

extension ColorInfo: Equatable {}

/// - SeeAlso: Equatable.==
public func == (lhs: ColorInfo, rhs: ColorInfo) -> Bool {
	return (
		lhs.color == rhs.color &&
		lhs.score == rhs.score &&
		lhs.pixelFraction == rhs.pixelFraction
	)
}
