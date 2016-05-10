//
// ColorInformation.swift
//
// Copyright (c) 2016 Netguru Sp. z o.o. All rights reserved.
// Licensed under the MIT License.
//

/// Color information consists of RGB channels,
/// score and fraction of image the color occupies in the image.
public struct ColorInformation: APIRepresentationConvertible {

	/// RGB components of the color.
	let color: Color

	/// Image-specific score for this color. Value in range (0...1).
	let score: Double

	/// Stores the fraction of pixels the color occupies in the image. Value in range (0...1).
	let pixelFraction: Double

	// MARK: Errors

	/// Describes the errors which can be thrown inside this type.
	public enum Error: ErrorType {

		/// Thrown if the score is not in the correct range.
		case InvalidScore

		/// Thrown if the pixel fraction is not in the correct range.
		case InvalidPixelFraction
	}

	// MARK: Initializers

	/// Initializes the receiver with raw values.
	///
	/// - Parameters:
	///     - color: RGB components of the color.
	///     - score: Score for this color in the image.
	///     - pixelFraction: Fraction of pixels the color occupies in the image.
	///
	/// - Throws: Errors from `ColorInformation.Error` domain if the provided
	/// numeric values are out of their expected range.
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

	/// - SeeAlso: APIRepresentationConvertible.init(APIRepresentationValue:)
	public init(APIRepresentationValue value: APIRepresentationValue) throws {
		try self.init(
			color: value.get("color"),
			score: value.get("score"),
			pixelFraction: value.get("pixelFraction")
		)
	}
}
// MARK: -

extension ColorInformation: Equatable {}

/// - SeeAlso: Equatable.==
public func == (lhs: ColorInformation, rhs: ColorInformation) -> Bool {
	return (
		lhs.color == rhs.color &&
		lhs.score == rhs.score &&
		lhs.pixelFraction == rhs.pixelFraction
	)
}
