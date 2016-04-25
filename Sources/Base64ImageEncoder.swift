//
// Base64ImageEncoder.swift
//
// Copyright (c) 2016 Netguru Sp. z o.o. All rights reserved.
// Licensed under the MIT License.
//

import UIKit

/// A default base64 encoder to be used with Google Cloud Vision API.
public struct Base64ImageEncoder: ImageEncoding {

	/// Initializes the instance.
	public init() {}

	/// Describes errors which may occur during encoding.
	public enum Error: ErrorType {
		case UnsupportedBitmapData
	}

	/// Encodes the image into base64 representation.
	///
	/// - Throws: `UnsupportedBitmapData` if the given image contains no bitmap
	/// data or contains data in unsupported bitmap format.
	///
	/// - Parameter image: An image to be encoded.
	///
	/// - Returns: A string which contains encoded representation of the given
	/// image.
	public func encode(image image: UIImage) throws -> String {
		guard let data = UIImagePNGRepresentation(image) else {
			throw Error.UnsupportedBitmapData
		}
		return data.base64EncodedStringWithOptions([])
	}

}
