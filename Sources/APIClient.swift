//
// APIClient.swift
//
// Copyright (c) 2016 Netguru Sp. z o.o. All rights reserved.
// Licensed under the MIT License.
//

import Foundation

/// A default Google Cloud Vision API client.
public final class APIClient: APIClientType {

	/// The key to Google Cloud Vision API.
	public let APIKey: String

	/// Image encoder which converts image to data.
	public let encoder: ImageEncoding

	/// An URL session used to create data task.
	private let session: NSURLSession

	// MARK: Errors

	/// Describes an API client error.
	public enum Error: ErrorType {

		/// Thrown if the API key is corrupted and cannot be percent encoded to
		/// be used in Google Cloud Vision API request.
		case CorruptedAPIKey

		/// Returned if Google Cloud Vision API reponse status code is not OK.
		case BadResponse(NSHTTPURLResponse)

		/// Returned if Google Cloud Vision API reponse type is not HTTP.
		case UnsupportedResponseType(NSURLResponse)

		/// Returned if Google Cloud Vision API does not return any reponse.
		case NoResponse
	}

	// MARK: Initializers

	/// Initializes the receiver.
	///
	/// - Parameters:
	///     - APIKey: Google Cloud Vision API key.
	///     - encoder: Image encoder which converts image to data.
	///     - session: URL session used to create data task. By default creates
	///       a session with default configuration.
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
	public func perform(request request: AnnotationRequest, completion: (PicguardResult<AnnotationResponse>) -> Void) {
		do {
			let URLRequest = try composeURLRequest(annotationRequest: request)
			let dataTask = createDataTask(URLRequest: URLRequest, completion: completion)
			dataTask.resume()
		} catch let error {
			dispatch_async(dispatch_get_main_queue()) {
				completion(PicguardResult.Error(error))
			}
		}
	}
}

// MARK: -

private extension APIClient {

	// MARK: Request composition

	// swiftlint:disable force_cast

	/// Creates URL request using annotation request and APIKey.
	///
	/// - Parameters:
	///     - annotationRequest: The source annotation request.
	///
	/// - Throws: Rethrows any errors thrown by `NSJSONSerialization` while
	///   creating request body.
	///
	/// - Returns: A composed `NSURLRequest` instance.
	func composeURLRequest(annotationRequest annotationRequest: AnnotationRequest) throws -> NSURLRequest {
		guard let APIKey = (APIKey as NSString).stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.alphanumericCharacterSet()) else {
			throw Error.CorruptedAPIKey
		}
		guard let URL = NSURL(string: "https://vision.googleapis.com/v1/images:annotate?key=\(APIKey)") else {
			throw Error.CorruptedAPIKey
		}
		let request = NSMutableURLRequest(URL: URL)
		request.HTTPMethod = "POST"
		request.HTTPBody = try NSJSONSerialization.dataWithJSONObject([
			"requests": [
				try annotationRequest.JSONDictionaryRepresentation(encoder)
			]
		], options: [])
		request.setValue("application/json", forHTTPHeaderField: "Content-Type")
		return request.copy() as! NSURLRequest
	}

	// swiftlint:enable force_cast

	/// Creates data task using URL request and completion closure.
	///
	/// - Parameters:
	///     - URLRequest: The URL request to send with data task.
	///     - completion: The completion closure to be execured.
	///
	/// - Returns: Configured `NSURLSessionDataTask`.
	func createDataTask(URLRequest URLRequest: NSURLRequest, completion: (PicguardResult<AnnotationResponse>) -> Void) -> NSURLSessionDataTask {
		return session.dataTaskWithRequest(URLRequest) { data, URLResponse, responseError in
			guard let URLResponse = URLResponse else {
				completion(.Error(Error.NoResponse))
				return
			}
			guard let HTTPURLResponse = URLResponse as? NSHTTPURLResponse else {
				completion(.Error(Error.UnsupportedResponseType(URLResponse)))
				return
			}
			guard HTTPURLResponse.statusCode == 200 else {
				completion(.Error(Error.BadResponse(HTTPURLResponse)))
				return
			}
			if let responseError = responseError {
				completion(.Error(responseError))
			} else if let data = data {
				do {
					completion(try APIRepresentationValue(data: data).get("responses")[0] as PicguardResult<AnnotationResponse>)
				} catch let error {
					completion(.Error(error))
				}
			}
		}
	}
}
