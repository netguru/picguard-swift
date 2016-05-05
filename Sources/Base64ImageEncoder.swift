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

		/// Thrown if image cannot be converted to data.
		case UnsupportedBitmapData

		/// Thrown if data cannot be converted to image.
		case InvalidImageData
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

	/// Encodes the image data into base64 representation.
	///
	/// - Throws: `InvalidImageData` if the given image data cannot be converted
	/// to Image.
	///
	/// - Parameter image data: An image data to be encoded.
	///
	/// - Returns: A string which contains encoded representation of the given
	/// image data.
	public func encode(imageData imageData: NSData) throws -> String {
		guard let _ = UIImage(data: imageData) else {
			throw Error.InvalidImageData
		}
		return imageData.base64EncodedStringWithOptions([])
	}
}
