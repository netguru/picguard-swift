//
// PicguardResult.swift
//
// Copyright (c) 2016 Netguru Sp. z o.o. All rights reserved.
// Licensed under the MIT License.
//

/// Result returned by Google Cloud Vision API.
public enum PicguardResult<T: APIRepresentationConvertible>: APIRepresentationConvertible {

	/// Case when Google Cloud Vision API response is successful.
	case Success(T)

	/// Case when Google Cloud Vision API response is erroneous.
	case Error(ErrorType)

	// MARK: Initializers

	/// - SeeAlso: APIRepresentationConvertible.init(APIRepresentationValue:)
	public init(APIRepresentationValue value: APIRepresentationValue) {
		do {
			if let error = try value.get("status") as AnnotationError? {
				self = .Error(error)
			} else {
				self = .Success(try T(APIRepresentationValue: value))
			}
		} catch let error {
			self = .Error(error)
		}
	}

	// MARK: Transforms

	/// Applies a map transform over the successful value.
	///
	/// If `self` is `.Success`, returns a result of mapping `transform` over
	/// the stored value. If `self` is `.Error`, returns just `self`.
	///
	/// - Parameter transform: The transformation block. Errors thrown inside
	///   are caught and returned as wrapped in `.Error` case.
	///
	/// - Returns: A result of a map transform over the successful value.
	public func map<U: APIRepresentationConvertible>(@noescape transform: (T) throws -> U) -> PicguardResult<U> {
		switch self {
			case .Success(let value):
				do {
					return .Success(try transform(value))
				} catch let error {
					return .Error(error)
				}
			case .Error(let error):
				return .Error(error)
		}
	}

}
