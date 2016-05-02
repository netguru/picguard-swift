//
// Picguard.swift
//
// Copyright (c) 2016 Netguru Sp. z o.o. All rights reserved.
// Licensed under the MIT License.
//

import Foundation

/// Response containing annotations returned by Google Cloud Vision API.
public struct AnnotationResponse {

	/// Optional array of `LabelAnnotations`, returns nil if empty
	public let labelAnnotations: [LabelAnnotation]?

	/// Optional array of `TextAnnotations`, returns nil if empty
	public let textAnnotations: [Any]?

	/// Optional array of `FaceAnnotations`, returns nil if empty
	public let faceAnnotations: [Any]?

	/// Optional array of `LandmarkAnnotations`, returns nil if empty
	public let landmarkAnnotations: [Any]?

	/// Optional array of `LogoAnnotations`, returns nil if empty
	public let logoAnnotations: [Any]?

	/// Optional `SafeSearchAnnotation`
	public let safeSearchAnnotation: Any?

	/// Optional `ImagePropertiesAnnotation`
	public let imagePropertiesAnnotation: Any?

	/// Initializes the receiver with data from response.
	/// Returns nil if fails to parse response data.
	///
	/// - Parameter data: The data returned by Google Cloud Vision API

	public init?(data: NSData) {
		guard
			let JSONDictionary = try? NSJSONSerialization.JSONObjectWithData(data, options: [])
				as? Dictionary<String, AnyObject>,
			let responses = JSONDictionary?["responses"]
				as? Array<Dictionary<String, Array<AnyObject>>>,
			let response = responses.first else {
				return nil
		}

		labelAnnotations = response["labelAnnotations"].flatMap {
			try? $0.map {
				try LabelAnnotation(APIRepresentationValue: APIRepresentationValue(value: $0))
			}
		}

		textAnnotations = nil
		faceAnnotations = nil
		landmarkAnnotations = nil
		logoAnnotations = nil
		safeSearchAnnotation = nil
		imagePropertiesAnnotation = nil
	}
}
