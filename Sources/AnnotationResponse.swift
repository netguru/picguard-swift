//
// AnnotationResponse.swift
//
// Copyright (c) 2016 Netguru Sp. z o.o. All rights reserved.
// Licensed under the MIT License.
//

/// Response containing annotations returned by Google Cloud Vision API.
public struct AnnotationResponse: APIRepresentationConvertible {

	/// Array of label detection results.
	public let labelAnnotations: [LabelAnnotation]?

	/// Array of label detection results.
	public let faceAnnotations: [FaceAnnotation]?

	/// Array of label detection results.
	public let textAnnotations: [TextAnnotation]?

	/// Array of label detection results.
	public let landmarkAnnotations: [LandmarkAnnotation]?

	/// Array of label detection results.
	public let safeSearchAnnotations: [SafeSearchAnnotation]?

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
