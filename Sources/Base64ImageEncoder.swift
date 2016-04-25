//
// Base64ImageEncoder.swift
//
// Copyright (c) 2016 Netguru Sp. z o.o. All rights reserved.
// Licensed under the MIT License.
//

import UIKit

public struct Base64ImageEncoder: ImageEncoding {

	public init() {}

	/// Describes errors which may occur during encoding.
	public enum Error: ErrorType {
		case UnsupportedBitmapData
	}

	public func encode(image image: UIImage) throws -> String {
		guard let data = UIImagePNGRepresentation(image) else {
			throw Error.UnsupportedBitmapData
		}
		return data.base64EncodedStringWithOptions([])
	}

}
