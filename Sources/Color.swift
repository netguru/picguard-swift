//
// Color.swift
//
// Copyright (c) 2016 Netguru Sp. z o.o. All rights reserved.
// Licensed under the MIT License.
//

/// Represents a color in the RGBA color space.
public struct Color: APIRepresentationConvertible {

	/// The red component of the color (0...1).
	let red: Double

	/// The gren component of the color (0...1).
	let green: Double

	/// The blue component of the color (0...1).
	let blue: Double

	/// The color transparency (0...1).
	let alpha: Double?

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
	///     - red: Red color component.
	///     - green: Green color component.
	///     - blue: Blue color component.
	///     - alpha: Color transparency.
	///
	/// - Throws: `InvalidColorComponent` if the color component value is out of range.
	public init(red: Double, green: Double, blue: Double, alpha: Double?) throws {
		guard 0...1 ~= red else {
			throw Error.InvalidColorComponent
		}
		guard 0...1 ~= green else {
			throw Error.InvalidColorComponent
		}
		guard 0...1 ~= blue else {
			throw Error.InvalidColorComponent
		}
		if let alpha = alpha {
			guard 0...1 ~= alpha else {
				throw Error.InvalidColorComponent
			}
			self.alpha = alpha
		} else {
			self.alpha = 1
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
			blue: value.get("blue") / 255,
			alpha: value.get("alpha")
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
		lhs.blue == rhs.blue &&
		lhs.alpha == rhs.alpha
	)
}
