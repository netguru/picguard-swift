//
// ImageEncoding.swift
//
// Copyright (c) 2016 Netguru Sp. z o.o. All rights reserved.
// Licensed under the MIT License.
//

import UIKit

/// Describes a type that is capable of endoding an image or image data to be used with
/// Google Cloud Vision API.
public protocol ImageEncoding {

	/// Encodes an image.
	///
	/// - Parameter image: An image to be encoded.
	///
	/// - Returns: A string which contains encoded representation of the given
	/// image.
	func encode(image image: UIImage) throws -> String

	/// Encodes an image data.
	///
	/// - Parameter image data: An image data to be encoded.
	///
	/// - Returns: A string which contains encoded representation of the given
	/// image data.
	func encode(imageData imageData: NSData) throws -> String
}
