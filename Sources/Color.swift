//
// Color.swift
//
// Copyright (c) 2016 Netguru Sp. z o.o. All rights reserved.
// Licensed under the MIT License.
//

/// Represents a color in the RGBA color space.
public struct Color: APIRepresentationConvertible {

	/// The amount of red in the color as a value in the interval (0...1).
	let red: Double

	/// The amount of green in the color as a value in the interval (0...1).
	let green: Double

	/// The amount of blue in the color as a value in the interval (0...1).
	let blue: Double

	// MARK: Errors

	/// Describes errors which can be thrown inside this type.
	public enum Error: ErrorType {

		/// Thrown if the color component value is out of range.
		case InvalidColorComponent
	}

	// MARK: Initializers

	/// Initializes the receiver with raw values.
	///
	/// - Parameters:
	///     - red: Red color component value.
	///     - green: Green color component value.
	///     - blue: Blue color component value.
	///
	/// - Throws: `InvalidColorComponent` if the color component value is out of range.
	public init(red: Double, green: Double, blue: Double) throws {
		guard 0...1 ~= red else {
			throw Error.InvalidColorComponent
		}
		guard 0...1 ~= green else {
			throw Error.InvalidColorComponent
		}
		guard 0...1 ~= blue else {
			throw Error.InvalidColorComponent
		}
		self.red = red
		self.green = green
		self.blue = blue
	}

	/// - SeeAlso: APIRepresentationConvertible.init(APIRepresentationValue:)
	public init(APIRepresentationValue value: APIRepresentationValue) throws {
		try self.init(
			red: value.get("red") / 255,
			green: value.get("green") / 255,
			blue: value.get("blue") / 255
		)
	}
}

// MARK: -

extension Color: Equatable {}

/// - SeeAlso: Equatable.==
public func == (lhs: Color, rhs: Color) -> Bool {
	return (
		lhs.red == rhs.red &&
		lhs.green == rhs.green &&
		lhs.blue == rhs.blue
	)
}
