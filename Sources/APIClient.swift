//
// Picguard.swift
//
// Copyright (c) 2016 Netguru Sp. z o.o. All rights reserved.
// Licensed under the MIT License.
//


public protocol APIClientType {
	func perform(request request: AnnotationRequest, completion: AnnotationResult -> Void)
}

public final class APIClient: APIClientType {

	let key: String

	public init(key: String) {
		self.key = key
	}

	public func perform(request request: AnnotationRequest, completion: AnnotationResult -> Void) {
		completion(.Success(AnnotationResponse()))
	}
}
