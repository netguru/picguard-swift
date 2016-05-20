//
// Base64EncodableImage.swift
//
// Copyright (c) 2016 Netguru Sp. z o.o. All rights reserved.
// Licensed under the MIT License.
//

/// Describes errors which can be thrown while encoding image data to base64 format.
public enum Base64EncodableImageError: ErrorType {

	/// Thrown if image cannot be converted to base64 data.
	case UnsupportedBitmapData
}

/// Describes image with base64 encoded string representation
/// to be used with Google Cloud Vision API.
public protocol Base64EncodableImage {

	/// Encodes the image into base64 string representation.
	///
	/// - Throws: Errors from `Base64EncodableImageError` domain,
	///   when base64 string representation cannot be produced.
	///
	/// - Returns: Base64 encoded string of image data.
	func base64EncodedStringRepresentation() throws -> String

}
