//
// MockImageEncoder.swift
//
// Copyright (c) 2016 Netguru Sp. z o.o. All rights reserved.
// Licensed under the MIT License.
//

import Foundation
import Picguard

struct MockImageEncoder: ImageEncoding {

	func encode(image image: ImageType) throws -> String {
		return "fixture encoded image"
	}

	func encode(imageData imageData: NSData) throws -> String {
		return "fixture encoded image data"
	}
}
