//
// MockBase64EncodableImage.swift
//
// Copyright (c) 2016 Netguru Sp. z o.o. All rights reserved.
// Licensed under the MIT License.
//

import Picguard

final class MockBase64EncodableImage: Base64EncodableImage {

	func base64EncodedStringRepresentation() throws -> String {
		return "fixture encoded image"
	}
}