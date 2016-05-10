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

	/// Array of face detection results.
	public let faceAnnotations: [FaceAnnotation]?

	/// Array of text detection results.
	public let textAnnotations: [TextAnnotation]?

	/// Array of landmark detection results.
	public let landmarkAnnotations: [LandmarkAnnotation]?

	/// Safe search detection result.
	public let safeSearchAnnotation: SafeSearchAnnotation?

	/// Image properties detection result.
	public let imagePropertiesAnnotation: ImagePropertiesAnnotation?

	// MARK: Initializers

	/// Initializes the receiver with raw values.
	///
	/// - Parameters:
	///     - labelAnnotations: Array containing label annotations.
	///     - faceAnnotations: Array containing face annotations.
	///     - textAnnotations: Array containing text annotations.
	///     - landmarkAnnotations: Array containing landmark annotations.
	///     - safeSearchAnnotation: Safe search annotation.
	///     - imagePropertiesAnnotation: Image properties annotation.
	public init(
		labelAnnotations: [LabelAnnotation]?,
		faceAnnotations: [FaceAnnotation]?,
		textAnnotations: [TextAnnotation]?,
		landmarkAnnotations: [LandmarkAnnotation]?,
		safeSearchAnnotation: SafeSearchAnnotation?,
		imagePropertiesAnnotation: ImagePropertiesAnnotation?
	) {
		self.labelAnnotations = labelAnnotations
		self.faceAnnotations = faceAnnotations
		self.textAnnotations = textAnnotations
		self.landmarkAnnotations = landmarkAnnotations
		self.safeSearchAnnotation = safeSearchAnnotation
		self.imagePropertiesAnnotation = imagePropertiesAnnotation
	}

	/// - SeeAlso: APIRepresentationConvertible.init(APIRepresentationValue:)
	public init(APIRepresentationValue value: APIRepresentationValue) throws {
		try self.init(
			labelAnnotations: value.get("labelAnnotations"),
			faceAnnotations: value.get("faceAnnotations"),
			textAnnotations: value.get("textAnnotations"),
			landmarkAnnotations: value.get("landmarkAnnotations"),
			safeSearchAnnotation: value.get("safeSearchAnnotation"),
			imagePropertiesAnnotation: value.get("imagePropertiesAnnotation")
		)
	}
}

// MARK: -

extension AnnotationResponse: Equatable {}

/// - SeeAlso: Equatable.==
public func == (lhs: AnnotationResponse, rhs: AnnotationResponse) -> Bool {
	return (
		lhs.labelAnnotations == rhs.labelAnnotations &&
		lhs.faceAnnotations == rhs.faceAnnotations &&
		lhs.textAnnotations == rhs.textAnnotations &&
		lhs.landmarkAnnotations == rhs.landmarkAnnotations &&
		lhs.safeSearchAnnotation == rhs.safeSearchAnnotation &&
		lhs.imagePropertiesAnnotation == rhs.imagePropertiesAnnotation
	)
}
