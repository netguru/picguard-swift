//
// ImageConverting.swift
//
// Copyright (c) 2016 Netguru Sp. z o.o. All rights reserved.
// Licensed under the MIT License.
//

import UIKit

/// Describes a type that is capable of converting an image to data.
public protocol ImageConverting {

	/// Converts an image.
	///
	/// - Parameter image: An image to be converted.
	///
	/// - Returns: An optional data representation of the given image.
	func convert(image image: UIImage) -> NSData?
}
