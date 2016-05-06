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
	func perform(request request: AnnotationRequest, completion: (AnnotationResult) -> Void)
}


/// A default Google Cloud Vision API client.
public final class APIClient: APIClientType {

	/// Describes an API client error.
	public enum Error: ErrorType {

		/// Returned if Google Cloud Vision API reponse status code is not OK.
		case BadResponse(NSHTTPURLResponse)

		/// Returned if Google Cloud Vision API reponse type is not HTTP.
		case UnsupportedResponseType(NSURLResponse)

		/// Returned if Google Cloud Vision API does not return any reponse.
		case NoResponse
	}

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
		session: NSURLSession = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
	) {
		self.APIKey = APIKey
		self.encoder = encoder
		self.session = session
	}

	/// - SeeAlso: APIClientType.perform(request:completion:)
	public func perform(request request: AnnotationRequest, completion: (AnnotationResult) -> Void) {
		do {
			let URLRequest = try createURLRequest(request)
			let dataTask = createDataTask(URLRequest, completion: completion)
			dataTask.resume()
		} catch let error {
			dispatch_async(dispatch_get_main_queue()) {
				completion(AnnotationResult.Error(error))
			}
		}
	}
}

// MARK: - Private methods

private extension APIClient {

	/// Creates URL request using annotation request and APIKey
	///
	/// - Throws: Rethrows any errors thrown by `NSJSONSerialization` while creating request body.
	///
	/// - Returns: Configured `NSURLRequest`.
	func createURLRequest(annotationRequest: AnnotationRequest) throws -> NSURLRequest {
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

	/// Created data task using URL request and completion block
	///
	/// - Returns: Configured `NSURLSessionDataTask`.
	func createDataTask(URLRequest: NSURLRequest, completion: (AnnotationResult) -> Void) -> NSURLSessionDataTask {
		return session.dataTaskWithRequest(URLRequest) { (data, URLResponse, responseError) in
			guard let URLResponse = URLResponse else {
				completion(AnnotationResult.Error(Error.NoResponse))
				return
			}
			guard let HTTPURLResponse = URLResponse as? NSHTTPURLResponse else {
				completion(AnnotationResult.Error(Error.UnsupportedResponseType(URLResponse)))
				return
			}
			guard HTTPURLResponse.statusCode == 200 else {
				completion(AnnotationResult.Error(Error.BadResponse(HTTPURLResponse)))
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
		}
	}
}

// MARK: - APIClient.Error

extension APIClient.Error: Equatable {}

/// - SeeAlso: Equatable.==
public func == (lhs: APIClient.Error, rhs: APIClient.Error) -> Bool {
	switch (lhs, rhs) {
		case (.NoResponse, .NoResponse): return true
		case let (.BadResponse(lhsResponse), .BadResponse(rhsResponse)):
			return lhsResponse == rhsResponse
		case let (.UnsupportedResponseType(lhsResponse), .UnsupportedResponseType(rhsResponse)):
			return lhsResponse == rhsResponse
		default: return false
	}
}
