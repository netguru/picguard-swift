//
// LabelAnnotation.swift
//
// Copyright (c) 2016 Netguru Sp. z o.o. All rights reserved.
// Licensed under the MIT License.
//

/// Describes the result of label detection.
public struct LabelAnnotation: APIRepresentationConvertible {

	/// The opaque identifier of the entity. Some IDs might be available in
	/// Google's Knowledge Graph.
	public let entityIdentifier: String

	/// A textual description of the entity, usually the subject of the result.
	public let description: String

	/// Overall score of the result (0...1).
	public let score: Double

	// MARK: Errors

	/// Describes errors which can be thrown inside this type.
	public enum Error: ErrorType {

		/// Thrown if the score is not in the correct range.
		case InvalidScore

	}

	// MARK: Initializers

	/// Initializes the receiver with raw values.
	///
	/// - Parameters:
	///     - entityIdentifier: The entity opaque identifier.
	///     - description: The textual description.
	///     - score: The score of the result.
	///
	/// - Throws: `InvalidScore` if the score is not in range `0...1`.
	public init(entityIdentifier: String, description: String, score: Double) throws {
		guard 0...1 ~= score else {
			throw Error.InvalidScore
		}
		self.entityIdentifier = entityIdentifier
		self.description = description
		self.score = score
	}

	/// - SeeAlso: APIRepresentationConvertible.init(APIRepresentationValue:)
	public init(APIRepresentationValue value: APIRepresentationValue) throws {
		try self.init(
			entityIdentifier: value.get("mid"),
			description: value.get("description"),
			score: value.get("score")
		)
	}

}
