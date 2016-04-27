//
// LabelDetectionResult.swift
//
// Copyright (c) 2016 Netguru Sp. z o.o. All rights reserved.
// Licensed under the MIT License.
//

/// Describes a singular result of label detection.
public struct LabelDetectionResult {

	/// The opaque identifier of the entity.
	public let entityIdentifier: String

	/// A textual description of the entity, usually the subject of the result.
	public let description: String

	/// The score of the result (in range 0...1).
	public let score: Double

	// MARK: Errors

	/// Describes errors which can be thrown inside this type.
	public enum Error: ErrorType {
		case InvalidScore
		case InvalidJSONRepresentation
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

	/// Initializes the receiver with a JSON representation.
	///
	/// - Parameter JSONRepresentation: The JSON dictionary representing the
	/// receiver.
	///
	/// - Throws: `InvalidJSONRepresentation` if the given JSON representation
	/// is invalid and cannot be successfully parsed.
	public init(JSONRepresentation: [String: Any]) throws {
		guard let entityIdentifier = JSONRepresentation["mid"] as? String else {
			throw Error.InvalidJSONRepresentation
		}
		guard let description = JSONRepresentation["description"] as? String else {
			throw Error.InvalidJSONRepresentation
		}
		guard let score = JSONRepresentation["score"] as? Double else {
			throw Error.InvalidJSONRepresentation
		}
		try self.init(entityIdentifier: entityIdentifier, description: description, score: score)
	}

}
