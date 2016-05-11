//
// Picguard.swift
//
// Copyright (c) 2016 Netguru Sp. z o.o. All rights reserved.
// Licensed under the MIT License.
//

import UIKit

public struct Picguard {

	private let APIClient: APIClientType

	public enum Error: ErrorType {
		case AnnotationsNotFound
	}

	public init(APIClient: APIClientType) {
		self.APIClient = APIClient
	}

	public func detectUnsafeContent(image image: UIImage, completion: (result: Result<Likelihood>) -> Void) {
		do {
			try APIClient.perform(
				request: AnnotationRequest(
					features: Set([.SafeSearch(maxResults: 1)]),
					image: .Image(image)
				),
				completion: { annotationResult in
					switch annotationResult {
						case .Success(let response):
							guard let safeSearchAnnotation = response.safeSearchAnnotation else {
								completion(result: .Error(Error.AnnotationsNotFound))
								return
							}
							completion(result: .Value(safeSearchAnnotation.adultContentLikelihood))
						case .Error(let error): completion(result: .Error(error))
					}
				}
			)
		} catch let error {
			dispatch_async(dispatch_get_main_queue()) {
				completion(result: .Error(error))
			}
		}
	}
}
