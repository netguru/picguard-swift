//
// Base64ImageEncoder.swift
//
// Copyright (c) 2016 Netguru Sp. z o.o. All rights reserved.
// Licensed under the MIT License.
//

import UIKit

public struct Base64ImageEncoder: ImageEncoding {

	public init() {}

	public func encode(image image: UIImage) throws -> String {
		guard let data = UIImagePNGRepresentation(image) else {
			throw NSError(domain: "", code: 0, userInfo: [:])
		}
		return data.base64EncodedStringWithOptions([])
	}

}
