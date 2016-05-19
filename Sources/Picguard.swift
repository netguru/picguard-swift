//
// Picguard.swift
//
// Copyright (c) 2016 Netguru Sp. z o.o. All rights reserved.
// Licensed under the MIT License.
//

import Dispatch

/// Provides image analysis using Google Cloud Vision API.
public struct Picguard {

	/// The API client for performing requests against Google Cloud Vision API.
	public let client: APIClientType

	// MARK: Initializers

	/// Initializes the receiver with API client.
	///
	/// - Parameter APIClient: API client for performing requests against Google
	///   Cloud Vision API.
	public init(APIClient: APIClientType) {
		client = APIClient
	}

	/// Initializes the Picguard instance using default donfiguration and the
	/// given Google Clous Vision API key.
	///
	/// - Parameter APIKey: Google Cloud Vision API key.
	public init(APIKey: String) {
		self.init(APIClient: APIClient(APIKey: APIKey, encoder: Base64ImageEncoder()))
	}

	// MARK: Annotations

	/// Annotates the given image with given feature set.
	///
	/// - Parameters:
	///     - image: Image to be annotated.
	///     - features: Annotations feature set.
	///     - completion: The completion closure executed when request finishes.
	public func annotate(image image: AnnotationRequest.Image, features: Set<AnnotationRequest.Feature>, completion: (PicguardResult<AnnotationResponse>) -> Void) {
		do {
			client.perform(
				request: try AnnotationRequest(features: features, image: image),
				completion: completion
			)
		} catch let error {
			dispatch_async(dispatch_get_main_queue()) {
				completion(.Error(error))
			}
		}
	}

	/// Detects likelihood of unsafe content in the image.
	///
	/// - Parameters:
	///     - image: Image to be analyzed.
	///     - completion: The completion closure executed when request finishes.
	public func detectUnsafeContentLikelihood(image image: AnnotationRequest.Image, completion: (PicguardResult<Likelihood>) -> Void) {
		annotate(image: image, features: [.SafeSearch]) { result in
			completion(result.map { response in
				guard let safeSearchAnnotation = response.safeSearchAnnotation else {
					return Likelihood.Unknown
				}
				return safeSearchAnnotation.unsafeContentLikelihood
			})
		}
	}

	/// Detects likelihood of any face presence in the image.
	///
	/// - Parameters:
	///     - image: Image to be analyzed.
	///     - completion: The completion closure executed when request finishes.
	public func detectFacePresenceLikelihood(image image: AnnotationRequest.Image, completion: (PicguardResult<Likelihood>) -> Void) {
		annotate(image: image, features: [.Face(maxResults: 1)]) { result in
			completion(result.map { response in
				guard let faceAnnotations = response.faceAnnotations where faceAnnotations.count > 0 else {
					return Likelihood.Unknown
				}
				return try Likelihood(score: faceAnnotations[0].detectionConfidence)
			})
		}
	}

}
