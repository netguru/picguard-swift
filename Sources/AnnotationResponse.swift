//
// AnnotationResponse.swift
//
// Copyright (c) 2016 Netguru Sp. z o.o. All rights reserved.
// Licensed under the MIT License.
//


/// Response containing annotations returned by Google Cloud Vision API.
public struct AnnotationResponse: APIRepresentationConvertible {

	/// Optional array of `LabelAnnotations` parsed from response data.
	public let labelAnnotations: [LabelAnnotation]?

	// MARK: Initializers

	/// Initializes the receiver with raw values.
	///
	/// - Parameter labelAnnotations: Optional array containing label annotations.
	public init(labelAnnotations: [LabelAnnotation]?) {
		self.labelAnnotations = labelAnnotations
	}

	/// - SeeAlso: APIRepresentationConvertible.init(APIRepresentationValue:)
	public init(APIRepresentationValue value: APIRepresentationValue) throws {
		labelAnnotations = try value.get("labelAnnotations")
	}
}

// MARK: -

extension AnnotationResponse: Equatable {}

/// - SeeAlso: Equatable.==
public func == (lhs: AnnotationResponse, rhs: AnnotationResponse) -> Bool {
	return lhs.labelAnnotations == rhs.labelAnnotations
}
