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

	/// Detects likelihood of unsafe content in the image.
	///
	/// - Parameters:
	///     - image: Image used for unsafe content detection.
	///     - completion: The closure with `PicguardResult<Likelihood>`, called when
	///       response comes from Google Cloud Vision API.
	public func detectUnsafeContentLikelihood(image image: UIImage, completion: (PicguardResult<Likelihood>) -> Void) {
		do {
			try client.perform(
				request: AnnotationRequest(
					features: [.SafeSearch(maxResults: 1)],
					image: .Image(image)
				)
			) { result in
				completion(result.map { response in
					guard let safeSearchAnnotation = response.safeSearchAnnotation else {
						return Likelihood.Unknown
					}
					return safeSearchAnnotation.unsafeContentLikelihood
				})
			}
		} catch let error {
			dispatch_async(dispatch_get_main_queue()) {
				completion(.Error(error))
			}
		}
	}

	/// Detects likelihood of any face presence in the image.
	///
	/// - Parameters:
	///     - image: Image to be analyzed.
	///     - completion: The closure taking `PicguardResult<Likelihood>`.
	public func detectFacePresenceLikelihood(image image: UIImage, completion: (PicguardResult<Likelihood>) -> Void) {
		do {
			try client.perform(
				request: AnnotationRequest(
					features: [.Face(maxResults: 1)],
					image: .Image(image)
				)
			) { result in
				do {
					completion(try result.map { response in
						guard let faceAnnotations = response.faceAnnotations where faceAnnotations.count > 0 else {
							return Likelihood.Unknown
						}
						return try Likelihood(score: faceAnnotations[0].detectionConfidence)
					})
				} catch let error {
					dispatch_async(dispatch_get_main_queue()) {
						completion(.Error(error))
					}
				}
			}
		} catch let error {
			dispatch_async(dispatch_get_main_queue()) {
				completion(.Error(error))
			}
		}
	}

}
