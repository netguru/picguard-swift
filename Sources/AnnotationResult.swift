//
// AnnotationResult.swift
//
// Copyright (c) 2016 Netguru Sp. z o.o. All rights reserved.
// Licensed under the MIT License.
//

import Foundation

/// Result returned by Google Cloud Vision API.
public enum AnnotationResult: APIRepresentationConvertible {

	/// Case when Google Cloud Vision API response is successful.
	case Success(AnnotationResponse)

	/// Case when Google Cloud Vision API response is erroneous.
	case Error(ErrorType)

	// MARK: Initializers

	/// - SeeAlso: APIRepresentationConvertible.init(APIRepresentationValue:)
	public init(APIRepresentationValue value: APIRepresentationValue) {
		do {
			if let error = try value.get("status") as AnnotationError? {
				self = .Error(error)
			} else {
				self = .Success(try AnnotationResponse(APIRepresentationValue: value))
			}
		} catch let error {
			self = .Error(error)
		}
	}

}
