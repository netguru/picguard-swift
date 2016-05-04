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

	/// Thrown if could not compose valid URL request.
	case InvalidRequestParameters

	/// Thrown if Google Cloud Vision API reponse status code is not OK.
	case BadServerResponse
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
	///		By default creates session with default configuration.
	public init(
		APIKey: String,
		encoder: ImageEncoding,
		session: NSURLSession = NSURLSession(
			configuration:NSURLSessionConfiguration.defaultSessionConfiguration()
			)
		) {
		self.APIKey = APIKey
		self.encoder = encoder
		self.session = session
	}

	public func perform(request request: AnnotationRequest,
	                            completion: AnnotationResult -> Void) throws {

		let URLRequest = try composeURLRequest(request)
		session.dataTaskWithRequest(URLRequest) { (data, URLResponse, error) in
			guard
			let HTTPURLResponse = URLResponse as? NSHTTPURLResponse
			where HTTPURLResponse.statusCode == 200 else {
				completion(AnnotationResult.Error(APIClientError.BadServerResponse))
				return
			}
			if let error = error {
				completion(AnnotationResult.Error(error))
			} else if let data = data {
				completion(AnnotationResult.Success(AnnotationResponse(data: data)))
			}
		}.resume()
	}
}

// MARK: - Private methods

private extension APIClient {

	func composeURLRequest(annotationRequest: AnnotationRequest) throws -> NSURLRequest {
		let requestJSONDictionary = try annotationRequest.JSONDictionaryRepresentation(encoder)
		let requestsJSONDictioanry = ["requests": [requestJSONDictionary]]
		let requestsJSONData = try NSJSONSerialization.dataWithJSONObject(requestsJSONDictioanry,
		                                                        options: [])
		let components = NSURLComponents()
		components.scheme = "https"
		components.host = "vision.googleapis.com"
		components.path = "/v1/images:annotate"
		components.queryItems = [NSURLQueryItem(name: "key", value: APIKey)]
		guard let URL = components.URL else {
			throw APIClientError.InvalidRequestParameters
		}
		let mutableRequest = NSMutableURLRequest(URL: URL)
		mutableRequest.HTTPMethod = "POST"
		mutableRequest.HTTPBody = requestsJSONData
		mutableRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
		guard let request = mutableRequest.copy() as? NSURLRequest else {
			throw APIClientError.InvalidRequestParameters
		}
		return request
	}
}
