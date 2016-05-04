//
// Picguard.swift
//
// Copyright (c) 2016 Netguru Sp. z o.o. All rights reserved.
// Licensed under the MIT License.
//

import Foundation

/// Response containing annotations returned by Google Cloud Vision API.
public struct AnnotationResponse: APIRepresentationConvertible {

	/// Optional array of `LabelAnnotations` parsed from response data.
	public let labelAnnotations: [LabelAnnotation]?

	public init(APIRepresentationValue value: APIRepresentationValue) throws {
		labelAnnotations = try value.get("labelAnnotations")
	}
}
