//
// AnnotationResult.swift
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
