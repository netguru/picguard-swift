//
// Likelihood.swift
//
// Copyright (c) 2016 Netguru Sp. z o.o. All rights reserved.
// Licensed under the MIT License.
//

/// A bucketized representation of likelihood.
public enum Likelihood: APIRepresentationConvertible {

	/// Unknown likelihood.
	case Unknown

	/// The image very unlikely belongs to the vertical specified.
	case VeryUnlikely

	/// The image unlikely belongs to the vertical specified.
	case Unlikely

	/// The image possibly belongs to the vertical specified.
	case Possible

	/// The image likely belongs to the vertical specified.
	case Likely

	/// The image very likely belongs to the vertical specified.
	case VeryLikely

	// MARK: Errors

	/// Describes errors which can be thrown inside this type.
	public enum Error: ErrorType {

		/// Thrown if representation string is invalid.
		case InvalidStringValue
	}

	// MARK: Initializers

	/// Initializes the receiver with a string.
	///
	/// - Parameter string: The string representation of the receiver.
	///
	/// - Throws: `Error.InvalidStringValue` if the string is invalid.
	public init(string: String) throws {
		switch string {
			case "UNKNOWN": self = .Unknown
			case "VERY_UNLIKELY": self = .VeryUnlikely
			case "UNLIKELY": self = .Unlikely
			case "POSSIBLE": self = .Possible
			case "LIKELY": self = .Likely
			case "VERY_LIKELY": self = .VeryLikely
			default: throw Error.InvalidStringValue
		}
	}

	/// - SeeAlso: APIRepresentationConvertible.init(APIRepresentationValue:)
	public init(APIRepresentationValue value: APIRepresentationValue) throws {
		guard case .String(let string) = value else {
			throw APIRepresentationError.UnexpectedValueType
		}
		try self.init(string: string)
	}

}
