//
// TextAnnotation.swift
//
// Copyright (c) 2016 Netguru Sp. z o.o. All rights reserved.
// Licensed under the MIT License.
//

/// Describes the result of text detection.
public struct TextAnnotation: APIRepresentationConvertible {

	/// Image region to which this annotation belongs. Produced for entire text
	/// detected in an image region, followed by bounding polygons for each word
	/// within detected text.
	public let boundingPolygon: BoundingPolygon

	/// The detected text, expressed in its `locale` language.
	public let description: String

	/// The language code for the locale in which the detected text is
	/// expressed. Filled only for entire text detected in an image region.
	public let locale: String?

	// MARK: Initializers

	/// Initializes the receiver with raw values.
	///
	/// - Parameters:
	///     - boundingPolygon: Image region to which this annotation belongs.
	///     - description: The detected text.
	///     - locale: The language code for the locale
	public init(boundingPolygon: BoundingPolygon, description: String, locale: String?) {
		self.boundingPolygon = boundingPolygon
		self.description = description
		self.locale = locale
	}

	/// - SeeAlso: APIRepresentationConvertible.init(APIRepresentationValue:)
	public init(APIRepresentationValue value: APIRepresentationValue) throws {
		try self.init(
			boundingPolygon: value.get("boundingPoly"),
			description: value.get("description"),
			locale: value.get("locale")
		)
	}

}

// MARK: -

extension TextAnnotation: Equatable {}

/// - SeeAlso: Equatable.==
public func == (lhs: TextAnnotation, rhs: TextAnnotation) -> Bool {
	return (
		lhs.boundingPolygon == rhs.boundingPolygon &&
		lhs.description == rhs.description &&
		lhs.locale == rhs.locale
	)
}
