//
// Base64EncodableImage.swift
//
// Copyright (c) 2016 Netguru Sp. z o.o. All rights reserved.
// Licensed under the MIT License.
//

public enum Base64EncodableImageError: ErrorType {

	/// Thrown if image cannot be converted to data.
	case UnsupportedBitmapData
}

public protocol Base64EncodableImage {

	func base64EncodedStringRepresentation() throws -> String

}
