//
//  ImagePropertiesAnnotation.swift
//
// Copyright (c) 2016 Netguru Sp. z o.o. All rights reserved.
// Licensed under the MIT License.
//

public struct ImagePropertiesAnnotation: APIRepresentationConvertible {

	let dominantColorsAnnotation: DominantColorsAnnotation

	public init(dominantColorsAnnotation: DominantColorsAnnotation) {
		self.dominantColorsAnnotation = dominantColorsAnnotation
	}

	public init(APIRepresentationValue value: APIRepresentationValue) throws {
		try self.init(dominantColorsAnnotation: value.get("dominantColors"))
	}
}

// MARK: -

extension ImagePropertiesAnnotation: Equatable {}

/// - SeeAlso: Equatable.==
public func == (lhs: ImagePropertiesAnnotation, rhs: ImagePropertiesAnnotation) -> Bool {
	return lhs.dominantColorsAnnotation == rhs.dominantColorsAnnotation
}
