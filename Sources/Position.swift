//
// Position.swift
//
// Copyright (c) 2016 Netguru Sp. z o.o. All rights reserved.
// Licensed under the MIT License.
//

/// Describes a 3D position inside the image. The position coordinates are in
/// the same scale as the original image.
public struct Position: APIRepresentationConvertible {

	/// X coordinate.
	public let x: Double

	/// Y coordinate.
	public let y: Double

	/// Z coordinate (or depth).
	public let z: Double

	// MARK: Initializers

	/// Initializes the receiver.
	///
	/// - Parameters:
	///     - x: X coordinate.
	///     - y: Y coordinate.
	///     - z: Z coordinate.
	public init(x: Double, y: Double, z: Double) {
		self.x = x
		self.y = y
		self.z = z
	}

	/// - SeeAlso: APIRepresentationConvertible.init(APIRepresentationValue:)
	public init(APIRepresentationValue value: APIRepresentationValue) throws {
		try self.init(
			x: value.get("x"),
			y: value.get("y"),
			z: value.get("z")
		)
	}

}

// MARK: -

extension Position: Equatable {}

/// - SeeAlso: Equatable.==
public func == (lhs: Position, rhs: Position) -> Bool {
	return (
		lhs.x == rhs.x &&
		lhs.y == rhs.y &&
		lhs.z == rhs.z
	)
}
