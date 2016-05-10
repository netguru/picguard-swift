//
// AnnotationResponse.swift
//
// Copyright (c) 2016 Netguru Sp. z o.o. All rights reserved.
// Licensed under the MIT License.
//

/// Response containing annotations returned by Google Cloud Vision API.
public struct AnnotationResponse: APIRepresentationConvertible {

	/// Array of face detection results.
	public let faceAnnotations: [FaceAnnotation]?

	/// Array of label detection results.
	public let labelAnnotations: [LabelAnnotation]?

	/// Array of landmark detection results.
	public let landmarkAnnotations: [LandmarkAnnotation]?

	/// Array of logo detection results.
	public let logoAnnotations: [LogoAnnotation]?

	/// Array of text detection results.
	public let textAnnotations: [TextAnnotation]?

	/// Safe search detection result.
	public let safeSearchAnnotation: SafeSearchAnnotation?

	/// Image properties detection result.
	public let imagePropertiesAnnotation: ImagePropertiesAnnotation?

	// MARK: Initializers

	// swiftlint:disable function_parameter_count

	/// Initializes the receiver with raw values.
	///
	/// - Parameters:
	///     - faceAnnotations: Array containing face annotations.
	///     - labelAnnotations: Array containing label annotations.
	///     - landmarkAnnotations: Array containing landmark annotations.
	///     - logoAnnotations: Array containing logo annotations.
	///     - textAnnotations: Array containing text annotations.
	///     - safeSearchAnnotation: Safe search annotation.
	///     - imagePropertiesAnnotation: Image properties annotation.
	public init(
		faceAnnotations: [FaceAnnotation]?,
		labelAnnotations: [LabelAnnotation]?,
		landmarkAnnotations: [LandmarkAnnotation]?,
		logoAnnotations: [LogoAnnotation]?,
		textAnnotations: [TextAnnotation]?,
		safeSearchAnnotation: SafeSearchAnnotation?,
		imagePropertiesAnnotation: ImagePropertiesAnnotation?
	) {
		self.faceAnnotations = faceAnnotations
		self.labelAnnotations = labelAnnotations
		self.landmarkAnnotations = landmarkAnnotations
		self.logoAnnotations = logoAnnotations
		self.textAnnotations = textAnnotations
		self.safeSearchAnnotation = safeSearchAnnotation
		self.imagePropertiesAnnotation = imagePropertiesAnnotation
	}

	// swiftlint:enable function_parameter_count

	/// - SeeAlso: APIRepresentationConvertible.init(APIRepresentationValue:)
	public init(APIRepresentationValue value: APIRepresentationValue) throws {
		try self.init(
			faceAnnotations: value.get("faceAnnotations"),
			labelAnnotations: value.get("labelAnnotations"),
			landmarkAnnotations: value.get("landmarkAnnotations"),
			logoAnnotations: value.get("logoAnnotations"),
			textAnnotations: value.get("textAnnotations"),
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
