//
// Picguard.swift
//
// Copyright (c) 2016 Netguru Sp. z o.o. All rights reserved.
// Licensed under the MIT License.
//

import UIKit

/// Provides image analysis using Google Cloud Vision API.
public struct Picguard {

	public let client: APIClientType

	// MARK: Initializers

	/// Initialize the receiver with API key.
	///
	/// - Parameter APIKey: Google Cloud Vision API key.
	public init(APIKey: String) {
		self.init(APIClient: APIClient(APIKey: APIKey, encoder: Base64ImageEncoder()))
	}

	/// Initialize the receiver with API client.
	///
	/// - Parameter APIClientType: API client conforming to `APIClientType`.
	public init(APIClient: APIClientType) {
		client = APIClient
	}

	/// Detects unsafe content in the image.
	///
	/// - Parameters:
	///     - image: Image used for unsafe content detection.
	///     - completion: The closure with `PicguardResult<Likelihood>`, called when
	///       response comes from Google Cloud Vision API.
	public func detectUnsafeContent(image image: UIImage, completion: (result: PicguardResult<Likelihood>) -> Void) {
		do {
			try client.perform(
				request: AnnotationRequest(features: Set([.SafeSearch(maxResults: 1)]),
				image: .Image(image))
			) { result in
				switch result {
				case .Success(let response):
					guard let safeSearchAnnotation = response.safeSearchAnnotation else {
						completion(result: .Success(Likelihood.Unknown))
						return
					}
					completion(result: .Success(safeSearchAnnotation.unsafeContentLikelihood))
				case .Error(let error):
					completion(result: .Error(error))
				}
			}
		} catch let error {
			dispatch_async(dispatch_get_main_queue()) {
				completion(result: .Error(error))
			}
		}
	}

}
