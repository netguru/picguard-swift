//
// Picguard.swift
//
// Copyright (c) 2016 Netguru Sp. z o.o. All rights reserved.
// Licensed under the MIT License.
//

import Foundation

/// Describes a type that is capable of sending image analysis requests
/// to Google Cloud Vision API.
public protocol APIClientType {

	/// Sends request to Google Cloud Vision API.
	///
	/// - Parameter request: An `AnnotationRequest` describing image type and detection features.
	///
	/// - Parameter completion: The closure with `AnnotationResult`,
	/// called when response comes from Google Cloud Vision API.
	///
	/// - Throws: Errors from `APIClientError` domain or other errors while composing URL request.
	func perform(request request: AnnotationRequest, completion: (AnnotationResult) -> Void) throws
}

/// Describes an API client error.
public enum APIClientError: ErrorType {

	/// Thrown if Google Cloud Vision API reponse status code is not OK.
	case BadResponse(NSHTTPURLResponse)
}

/// A default Google Cloud Vision API client.
public final class APIClient: APIClientType {

	/// The key to Google Cloud Vision API.
	public let APIKey: String

	/// Image encoder which converts image to data.
	public let encoder: ImageEncoding

	/// An URL session used to create data task.
	private let session: NSURLSession

	/// Initializes the receiver with Google Cloud Vision API key, image encoder and URL session.
	///
	/// - Parameters:
	///     - APIKey: Google Cloud Vision API key.
	///     - encoder: Image encoder which converts image to data.
	///     - session: URL session used to create data task.
	/// By default creates session with default configuration.
	public init(
		APIKey: String,
		encoder: ImageEncoding,
		session: NSURLSession = NSURLSession(configuration:NSURLSessionConfiguration.defaultSessionConfiguration())
	) {
		self.APIKey = APIKey
		self.encoder = encoder
		self.session = session
	}

	public func perform(request request: AnnotationRequest, completion: (AnnotationResult) -> Void) throws {

		let URLRequest = try composeURLRequest(request)
		session.dataTaskWithRequest(URLRequest) { (data, URLResponse, responseError) in
			let HTTPURLResponse = URLResponse as! NSHTTPURLResponse
			guard HTTPURLResponse.statusCode == 200 else {
				completion(AnnotationResult.Error(APIClientError.BadResponse(HTTPURLResponse)))
				return
			}
			if let responseError = responseError {
				completion(AnnotationResult.Error(responseError))
			} else if let data = data {
				do {
					let value = try APIRepresentationValue(data: data)
					let responses: [AnnotationResponse] = try value.get("responses")
					let response = responses[0]
					completion(AnnotationResult.Success(response))
				} catch let error {
					completion(AnnotationResult.Error(error))
				}
			}
		}.resume()
	}
}

// MARK: - Private methods

private extension APIClient {

	func composeURLRequest(annotationRequest: AnnotationRequest) throws -> NSURLRequest {
		let requestJSONDictionary = try annotationRequest.JSONDictionaryRepresentation(encoder)
		let requestsJSONDictioanry = ["requests": [requestJSONDictionary]]
		let requestsJSONData = try NSJSONSerialization.dataWithJSONObject(requestsJSONDictioanry, options: [])
		let URL = NSURL(string: "https://vision.googleapis.com/v1/images:annotate?key=\(APIKey)")
		let request = NSMutableURLRequest(URL: URL!)
		request.HTTPMethod = "POST"
		request.HTTPBody = requestsJSONData
		request.setValue("application/json", forHTTPHeaderField: "Content-Type")
		return request.copy() as! NSURLRequest
	}
}
