//
// BoundingPolygon.swift
//
// Copyright (c) 2016 Netguru Sp. z o.o. All rights reserved.
// Licensed under the MIT License.
//

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
		self.init(vertices: try value.get("vertices") { value in
			do {
				return try Vertex(APIRepresentationValue: value)
			} catch APIRepresentationError.MissingDictionaryKey {
				return nil
			}
		})
	}

}

// MARK: -

extension BoundingPolygon: Equatable {}

/// - SeeAlso: Equatable.==
public func == (lhs: BoundingPolygon, rhs: BoundingPolygon) -> Bool {
	return lhs.vertices == rhs.vertices
}
