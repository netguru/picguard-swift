//
// PNGImageConverter.swift
//
// Copyright (c) 2016 Netguru Sp. z o.o. All rights reserved.
// Licensed under the MIT License.
//

#if os(iOS)
	import UIKit
#endif

#if os(OSX)
	import AppKit
#endif

public struct PNGImageConverter: ImageConverting {

	// MARK: Initializers

	/// Default initializer.
	public init() {}

	/// Converts an image to PNG data.
	///
	/// - Parameter image: An image to be converted to PNG data.
	///
	/// - Returns: An optional PNG data representation of the given image.
	public func convert(image image: UIImage) -> NSData? {
		#if os(iOS)
			return UIImagePNGRepresentation(image)
		#endif

		#if os(OSX)
			guard let cgImage = image.CGImageForProposedRect(nil, context: nil, hints: nil) else {
				return nil
			}
			return NSBitmapImageRep(CGImage: cgImage).representationUsingType(.NSPNGFileType, properties: [:])
		#endif
	}
}
