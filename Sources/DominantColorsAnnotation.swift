//
//  DominantColorsAnnotation.swift
//
// Copyright (c) 2016 Netguru Sp. z o.o. All rights reserved.
// Licensed under the MIT License.
//


public struct DominantColorsAnnotation: APIRepresentationConvertible {

	let colors: [ColorInfo]

	public init(colors: [ColorInfo]) {
		self.colors = colors
	}

	public init(APIRepresentationValue value: APIRepresentationValue) throws {
		try self.init(colors: value.get("colors"))
	}
}

// MARK: -

extension DominantColorsAnnotation: Equatable {}

/// - SeeAlso: Equatable.==
public func == (lhs: DominantColorsAnnotation, rhs: DominantColorsAnnotation) -> Bool {
	return lhs.colors == rhs.colors
}
