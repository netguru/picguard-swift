//
// FaceLandmark.swift
//
// Copyright (c) 2016 Netguru Sp. z o.o. All rights reserved.
// Licensed under the MIT License.
//

public struct LogoAnnotation: APIRepresentationConvertible {

	public let entityIdentifier: String
	public let boundingPolygon: BoundingPolygon
	public let description: String
	public let score: Double

	// MARK: Errors

	/// Describes errors which can be thrown inside this type.
	public enum Error: ErrorType {

		/// Thrown if the score is not in the correct range.
		case InvalidScore
	}

	// MARK: Initializers

	public init(
		entityIdentifier: String,
		boundingPolygon: BoundingPolygon,
		description: String,
		score: Double
		) throws {
		guard 0...1 ~= score else {
			throw Error.InvalidScore
		}
		self.entityIdentifier = entityIdentifier
		self.boundingPolygon = boundingPolygon
		self.description = description
		self.score = score
	}

	/// - SeeAlso: APIRepresentationConvertible.init(APIRepresentationValue:)
	public init(APIRepresentationValue value: APIRepresentationValue) throws {
		try self.init(
			entityIdentifier: value.get("mid"),
			boundingPolygon: value.get("boundingPoly"),
			description: value.get("description"),
			score: value.get("score")
		)
	}
}
