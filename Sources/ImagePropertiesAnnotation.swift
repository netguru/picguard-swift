//
//  ImagePropertiesAnnotation.swift
//
// Copyright (c) 2016 Netguru Sp. z o.o. All rights reserved.
// Licensed under the MIT License.
//

public struct ImagePropertiesAnnotation: APIRepresentationConvertible {

	let dominantColors: [Color]

	public init(dominantColors: [Color]) {
		self.dominantColors = dominantColors
	}

	public init(APIRepresentationValue value: APIRepresentationValue) throws {
		try self.init(
			dominantColors: value.get("dominantColors")
		)
	}
}
