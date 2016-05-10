//
// ImagePropertiesAnnotation.swift
//
// Copyright (c) 2016 Netguru Sp. z o.o. All rights reserved.
// Licensed under the MIT License.
//

/// Describes the result of image properties detection.
public struct ImagePropertiesAnnotation: APIRepresentationConvertible {

	/// Array of dominan colors RGBA color values, with their scores and pixel fractions.
	let dominantColors: [ColorInformation]

	// MARK: Initializers

	/// Initializes the receiver with raw values.
	///
	/// - Parameter dominantColors: Array of colors with their scores and pixel fractions.
	public init(dominantColors: [ColorInformation]) {
		self.dominantColors = dominantColors
	}

	/// - SeeAlso: APIRepresentationConvertible.init(APIRepresentationValue:)
	public init(APIRepresentationValue value: APIRepresentationValue) throws {
		try self.init(dominantColors: value.get("dominantColors").get("colors"))
	}
}

// MARK: -

extension ImagePropertiesAnnotation: Equatable {}

/// - SeeAlso: Equatable.==
public func == (lhs: ImagePropertiesAnnotation, rhs: ImagePropertiesAnnotation) -> Bool {
	return lhs.dominantColors == rhs.dominantColors
}
