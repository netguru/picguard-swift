//
// APIRepresentable.swift
//
// Copyright (c) 2016 Netguru Sp. z o.o. All rights reserved.
// Licensed under the MIT License.
//

/// Annotates a type that can be converted from API representation.
public protocol APIRepresentationConvertible {

	/// Initializes the receiver with an API representation value.
	///
	/// - Parameter APIRepresentationValue: The API representation value.
	///
	/// - Throws: Errors from `APIRepresentationError` domain or any other
	/// errors specific to implementation.
	init(APIRepresentationValue value: APIRepresentationValue) throws

}

// MARK: -

extension Int: APIRepresentationConvertible {

	public init(APIRepresentationValue value: APIRepresentationValue) throws {
		guard case .Number(let wrapped) = value else {
			throw APIRepresentationError.UnexpectedValueType
		}
		self = Int(wrapped)
	}

}

// MARK: -

extension Double: APIRepresentationConvertible {

	public init(APIRepresentationValue value: APIRepresentationValue) throws {
		guard case .Number(let wrapped) = value else {
			throw APIRepresentationError.UnexpectedValueType
		}
		self = wrapped
	}

}

// MARK: -

extension Bool: APIRepresentationConvertible {

	public init(APIRepresentationValue value: APIRepresentationValue) throws {
		guard case .Bool(let wrapped) = value else {
			throw APIRepresentationError.UnexpectedValueType
		}
		self = wrapped
	}

}

// MARK: -

extension String: APIRepresentationConvertible {

	public init(APIRepresentationValue value: APIRepresentationValue) throws {
		guard case .String(let wrapped) = value else {
			throw APIRepresentationError.UnexpectedValueType
		}
		self = wrapped
	}

}
