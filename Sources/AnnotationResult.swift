//
// Picguard.swift
//
// Copyright (c) 2016 Netguru Sp. z o.o. All rights reserved.
// Licensed under the MIT License.
//

/// Result returned by Google Cloud Vision API.
public enum AnnotationResult {

	/// Type indicating successful Google Cloud Vision API respone.
	case Success(AnnotationResponse)

	/// Type indicating error when getting response from Google Cloud Vision API.
	case Error(ErrorType)
}

// MARK: -

extension AnnotationResult: Equatable {}

/// - SeeAlso: Equatable.==
public func == (lhs: AnnotationResult, rhs: AnnotationResult) -> Bool {
	switch (lhs, rhs) {
		case let (.Success(lhsResponse), .Success(rhsResponse)): return lhsResponse == rhsResponse
		case let (.Error(lhsError), .Error(rhsError)): return lhsError == rhsError
		default: return false
	}
}
