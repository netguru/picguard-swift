//
// AnnotationError.swift
//
// Copyright (c) 2016 Netguru Sp. z o.o. All rights reserved.
// Licensed under the MIT License.
//

/// Represents a API-side annotation error.
public struct AnnotationError: ErrorType, APIRepresentationConvertible {

	/// The code of the error.
	public let code: Int

	/// A non-localized error message.
	public let message: String

	// MARK: Initializers

	/// Initializes the receiver.
	///
	/// - Parameters:
	///     - code: The error code.
	///     - message: The error message.
	public init(code: Int, message: String) {
		self.code = code
		self.message = message
	}

	/// - SeeAlso: APIRepresentationConvertible.init(APIRepresentationValue:)
	public init(APIRepresentationValue value: APIRepresentationValue) throws {
		try self.init(
			code: value.get("code"),
			message: value.get("message")
		)
	}

}
