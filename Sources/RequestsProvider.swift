//
// Picguard.swift
//
// Copyright (c) 2016 Netguru Sp. z o.o. All rights reserved.
// Licensed under the MIT License.
//

import Foundation

enum RequestType {
	case Analyze
}

struct RequestsProvider {

	let apiKey: String

	init(apiKey: String) {
		self.apiKey = apiKey
	}

	func request(type type: RequestType) -> NSURLRequest {
		let components = NSURLComponents()
		components.scheme = "https"
		components.host = "vision.googleapis.com"
		components.path = "/v1/images:annotate"
		components.queryItems = [NSURLQueryItem(name: "key", value: apiKey)]
		guard let URL = components.URL else { return NSURLRequest() }
		let mutableRequest = NSMutableURLRequest(URL: URL)
		mutableRequest.HTTPMethod = "POST"
		mutableRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
		mutableRequest.HTTPBody = requestBody(type: type)
		guard let request = mutableRequest.copy() as? NSURLRequest else { return NSURLRequest() }
		return request
	}
}

// MARK: -

private extension RequestsProvider {

	func requestBody(type type: RequestType) -> NSData {
		return NSData()
	}
}
