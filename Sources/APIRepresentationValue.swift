//
// APIRepresentation.swift
//
// Copyright (c) 2016 Netguru Sp. z o.o. All rights reserved.
// Licensed under the MIT License.
//

import Foundation

/// Describes a API representation error.
public enum APIRepresentationError: ErrorType {

	/// Thrown if the value given during initialization is unsupported.
	case UnsupportedInitType

	/// Thrown if a convertible type cannot be initialized with the given
	/// representation type.
	case UnexpectedValueType

	/// Thrown if trying to access a nonexistent dictionary key.
	case MissingDictionaryKey

}

// MARK: -

/// Describes an API representation value.
public enum APIRepresentationValue {

	/// Represents a `null` JSON value.
	case Null

	/// Represents a numeric JSON value.
	case Number(Double)

	/// Represents a boolean JSON value.
	case Bool(Swift.Bool)

	/// Represents a string JSON value.
	case String(Swift.String)

	/// Represents an array JSON value.
	case Array([APIRepresentationValue])

	/// Represents a dictionary JSON value.
	case Dictionary([Swift.String: APIRepresentationValue])

}

// MARK: -

public extension APIRepresentationValue {

	/// Initializes the representation value with a value.
	///
	/// - Throws: `UnsupportedInitType` if the value given is of an unsupported
	///   type.
	///
	/// - Parameter value: The value to initialize the representation with.
	init(value: AnyObject) throws {
		switch value {
			case is NSNull:
				self = .Null
			case let value as NSNumber:
				if CFGetTypeID(value) == CFBooleanGetTypeID() {
					self = .Bool(value.boolValue)
				} else {
					self = .Number(value.doubleValue)
				}
			case let value as Swift.String:
				self = .String(value)
			case let value as [AnyObject]:
				self = try .Array(value.map(APIRepresentationValue.init(value:)))
			case let value as [Swift.String: AnyObject]:
				self = try .Dictionary(value.map(APIRepresentationValue.init(value:)))
			default:
				throw APIRepresentationError.UnsupportedInitType
		}
	}

	/// Initializes the representation with JSON data.
	///
	/// - Throws: Rethrows any errors thrown by `NSJSONSerialization` and
	///   `self.init(value:)`.
	///
	/// - Parameter data: The serialized JSON data.
	init(data: NSData) throws {
		let value = try NSJSONSerialization.JSONObjectWithData(data, options: [])
		try self.init(value: value)
	}

}

// MARK: -

public extension APIRepresentationValue {

	/// Returns a value under the given key from the representation.
	///
	/// - Parameter key: The key of value.
	///
	/// - Throws: `UnexpectedValueType` if the receiver is not a dictionary,
	///   `MissingDictionaryKey` if the key doesn't exist.
	///
	/// - Returns: A representation value.
	func get(key: Swift.String) throws -> APIRepresentationValue {
		guard case .Dictionary(let dictionary) = self else {
			throw APIRepresentationError.UnexpectedValueType
		}
		guard let value = dictionary[key] else {
			throw APIRepresentationError.MissingDictionaryKey
		}
		return value
	}

	/// Unwraps a value under the given key from the representation.
	///
	/// - Parameter key: The key of the value.
	///
	/// - Throws: The following errors:
	///     - `APIRepresentationError.UnexpectedValueType` if the receiver
	///       is not a dictionary,
	///     - `APIRepresentationError.MissingDictionaryKey` if the key doesn't
	///       exist,
	///     - Any other error thrown by `APIRepresentationConvertible.init`.
	///
	/// - Returns: An unwrapped represented value.
	func get<T: APIRepresentationConvertible>(key: Swift.String) throws -> T {
		return try T(APIRepresentationValue: get(key))
	}

	/// Unwraps a value under the given key from the representation.
	///
	/// - Parameter key: The key of the value.
	///
	/// - Throws: The following errors:
	///     - `APIRepresentationError.UnexpectedValueType` if the receiver
	///       is not a dictionary,
	///     - Any other error thrown by `APIRepresentationConvertible.init`.
	///
	/// - Returns: An unwrapped optional represented value.
	func get<T: APIRepresentationConvertible>(key: Swift.String) throws -> T? {
		do {
			if case .Null = try get(key) {
				return nil
			}
			return try get(key) as T
		} catch APIRepresentationError.MissingDictionaryKey {
			return nil
		}
	}

	/// Unwraps an array under the given key from the representation.
	///
	/// - Parameter key: The key of the array.
	///
	/// - Throws: The following errors:
	///     - `APIRepresentationError.UnexpectedValueType` if the receiver
	///       is not a dictionary or value is not an array,
	///     - `APIRepresentationError.MissingDictionaryKey` if the key doesn't
	///       exist,
	///     - Any other error thrown by `APIRepresentationConvertible.init`.
	///
	/// - Returns: An unwrapped represented array.
	func get<T: APIRepresentationConvertible>(key: Swift.String) throws -> [T] {
		guard case .Array(let array) = try get(key) else {
			throw APIRepresentationError.UnexpectedValueType
		}
		return try array.map(T.init(APIRepresentationValue:))
	}

	/// Unwraps an array under the given key from the representation.
	///
	/// - Parameter key: The key of the array.
	///
	/// - Throws: The following errors:
	///     - `APIRepresentationError.UnexpectedValueType` if the receiver
	///       is not a dictionary or value is not an array,
	///     - `APIRepresentationError.MissingDictionaryKey` if the key doesn't
	///       exist,
	///
	/// - Returns: An unwrapped represented array of optional values.
	func get<T: APIRepresentationConvertible>(key: Swift.String) throws -> [T?] {
		guard case .Array(let array) = try get(key) else {
			throw APIRepresentationError.UnexpectedValueType
		}
		return array.map { try? T.init(APIRepresentationValue: $0) }
	}

	/// Unwraps an array under the given key from the representation.
	///
	/// - Parameter key: The key of the array.
	///
	/// - Throws: The following errors:
	///     - `APIRepresentationError.UnexpectedValueType` if the receiver
	///       is not a dictionary or value is not a null or an array,
	///     - Any other error thrown by `APIRepresentationConvertible.init`.
	///
	/// - Returns: An unwrapped optional represented array.
	func get<T: APIRepresentationConvertible>(key: Swift.String) throws -> [T]? {
		do {
			if case .Null = try get(key) {
				return nil
			}
			return try get(key) as [T]
		} catch APIRepresentationError.MissingDictionaryKey {
			return nil
		}
	}

	/// Unwraps a dictioanry under the given key from the representation.
	///
	/// - Parameter key: The key of the array.
	///
	/// - Throws: The following errors:
	///     - `APIRepresentationError.UnexpectedValueType` if the receiver
	///       is not a dictionary or value is not a dictionary,
	///     - `APIRepresentationError.MissingDictionaryKey` if the key doesn't
	///       exist,
	///     - Any other error thrown by `APIRepresentationConvertible.init`.
	///
	/// - Returns: An unwrapped represented dictionary.
	func get<T: APIRepresentationConvertible>(key: Swift.String) throws -> [Swift.String: T] {
		guard case .Dictionary(let dictionary) = try get(key) else {
			throw APIRepresentationError.UnexpectedValueType
		}
		return try dictionary.map(T.init(APIRepresentationValue:))
	}

}

// MARK: -

extension APIRepresentationValue: Equatable {}

/// - SeeAlso: Equatable.==
public func == (lhs: APIRepresentationValue, rhs: APIRepresentationValue) -> Bool {
	switch (lhs, rhs) {
		case (.Null, .Null):
			return true
		case (.Number(let lhs), .Number(let rhs)):
			return lhs == rhs
		case (.Bool(let lhs), .Bool(let rhs)):
			return lhs == rhs
		case (.String(let lhs), .String(let rhs)):
			return lhs == rhs
		case (.Array(let lhs), .Array(let rhs)):
			return lhs == rhs
		case (.Dictionary(let lhs), .Dictionary(let rhs)):
			return lhs == rhs
		default:
			return false
	}
}
