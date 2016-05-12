//
// Picguard.swift
//
// Copyright (c) 2016 Netguru Sp. z o.o. All rights reserved.
// Licensed under the MIT License.
//

import UIKit

public struct Picguard {

	public let client: APIClientType

	public init(APIKey: String) {
		client = APIClient(APIKey: APIKey, encoder: Base64ImageEncoder())
	}

	public init(APIClient: APIClientType) {
		client = APIClient
	}

	public func detectUnsafeContent(image image: UIImage, completion: (result: PicguardResult<Likelihood>) -> Void) {
		do {
			try client.perform(
				request: AnnotationRequest(
					features: Set([.SafeSearch(maxResults: 1)]),
					image: .Image(image)
				),
				completion: { annotationResult in
					switch annotationResult {
						case .Value(let response):
							guard let safeSearchAnnotation = response.safeSearchAnnotation else {
								completion(result: .Value(Likelihood.Unknown))
								return
							}
							completion(result: .Value(safeSearchAnnotation.violentContentLikelihood))
						case .Error(let error):
							completion(result: .Error(error))
					}
			})
		} catch let error {
			dispatch_async(dispatch_get_main_queue()) {
				completion(result: .Error(error))
			}
		}
	}

}
