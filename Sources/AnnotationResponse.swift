//
// Picguard.swift
//
// Copyright (c) 2016 Netguru Sp. z o.o. All rights reserved.
// Licensed under the MIT License.
//

import Foundation

public struct AnnotationResponse {

	public let labelAnnotations: [LabelAnnotation]?
	public let textAnnotations: [Any]?
	public let faceAnnotations: [Any]?
	public let landmarkAnnotations: [Any]?
	public let logoAnnotations: [Any]?
	public let safeSearchAnnotation: Any?
	public let imagePropertiesAnnotation: Any?

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
