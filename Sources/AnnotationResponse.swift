//
// Picguard.swift
//
// Copyright (c) 2016 Netguru Sp. z o.o. All rights reserved.
// Licensed under the MIT License.
//

import Foundation

/// Response containing annotations returned by Google Cloud Vision API.
public struct AnnotationResponse {

	public enum Error: ErrorType {
		case ErrorParsingResponse
	}

	/// The data returned by Google Cloud Vision API.
	let data: NSData

	public init(data: NSData) {
		self.data = data
	}

	/// `LabelAnnotations` parsed from response data.
	///
	/// - Throws: `ErrorParsingResponse` if fails to parse the given data.
	///
	/// - Returns: Array of `LabelAnnotations`.
	public func labelAnnotations() throws -> [LabelAnnotation] {
		let response = try firstResponse(fromData: data)
		guard let labelAnnotationsDictionaries = response["labelAnnotations"] else {
			throw Error.ErrorParsingResponse
		}
		return try labelAnnotationsDictionaries.map {
			try LabelAnnotation(APIRepresentationValue: APIRepresentationValue(value: $0))
		}
	}
}

// MARK: - Private methods

private extension AnnotationResponse {

	func firstResponse(fromData data: NSData) throws -> Dictionary<String, Array<AnyObject>> {
		guard
			let JSONDictionary = try? NSJSONSerialization.JSONObjectWithData(data, options: [])
				as? Dictionary<String, AnyObject>,
			let responses = JSONDictionary?["responses"]
				as? Array<Dictionary<String, Array<AnyObject>>>,
			let response = responses.first else {
			throw Error.ErrorParsingResponse
		}
		return response
	}
}
