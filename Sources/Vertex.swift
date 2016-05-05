//
// Vertex.swift
//
// Copyright (c) 2016 Netguru Sp. z o.o. All rights reserved.
// Licensed under the MIT License.
//

/// A vertex represents a 2D point in the image. The vertex coordinates are in
/// the same scale as the original image.
public struct Vertex: APIRepresentationConvertible {

	/// X coordinate.
	public let x: Double

	/// Y coordinate.
	public let y: Double

	// MARK: Initializers

	/// Initializes the receiver.
	///
	/// - Parameters:
	///     - x: X coordinate.
	///     - y: Y coordinate.
	public init(x: Double, y: Double) {
		self.x = x
		self.y = y
	}

	/// - SeeAlso: APIRepresentationConvertible.init(APIRepresentationValue:)
	public init(APIRepresentationValue value: APIRepresentationValue) throws {
		try self.init(
			x: value.get("x"),
			y: value.get("y")
		)
	}

}

// MARK: -

extension Vertex: Equatable {}

/// - SeeAlso: Equatable.==
public func == (lhs: Vertex, rhs: Vertex) -> Bool {
	return (
		lhs.x == rhs.x &&
		lhs.y == rhs.y
	)
}
