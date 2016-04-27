//
// AnnotationGeometry.swift
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

/// A bounding polygon for the detected image annotation.
public struct BoundingPolygon: APIRepresentationConvertible {

	/// The bounding polygon vertices.
	public let vertices: [Vertex]

	// MARK: Initializers

	/// Initializes the receiver.
	///
	/// - Parameter vertices: The vertices.
	public init(vertices: [Vertex]) {
		self.vertices = vertices
	}

	/// - SeeAlso: APIRepresentationConvertible.init(APIRepresentationValue:)
	public init(APIRepresentationValue value: APIRepresentationValue) throws {
		try self.init(vertices: value.get("vertices"))
	}

}
