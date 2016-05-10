//
//  ImagePropertiesAnnotation.swift
//
// Copyright (c) 2016 Netguru Sp. z o.o. All rights reserved.
// Licensed under the MIT License.
//

private struct DominantColorsAnnotation: APIRepresentationConvertible {

	let colors: [ColorInfo]

	init(APIRepresentationValue value: APIRepresentationValue) throws {
		colors = try value.get("colors")
	}
}

public struct ImagePropertiesAnnotation: APIRepresentationConvertible {

	let dominantColors: [ColorInfo]

	public init(dominantColors: [ColorInfo]) {
		self.dominantColors = dominantColors
	}

	public init(APIRepresentationValue value: APIRepresentationValue) throws {
		let dominantColorsAnnotation: DominantColorsAnnotation = try value.get("dominantColors")
		self.init(dominantColors: dominantColorsAnnotation.colors)
	}
}

// MARK: -

extension ImagePropertiesAnnotation: Equatable {}

/// - SeeAlso: Equatable.==
public func == (lhs: ImagePropertiesAnnotation, rhs: ImagePropertiesAnnotation) -> Bool {
	return lhs.dominantColors == rhs.dominantColors
}
