//
// UIImage.swift
//
// Copyright (c) 2016 Netguru Sp. z o.o. All rights reserved.
// Licensed under the MIT License.
//

import UIKit

extension UIImage: Base64EncodableImage {

	/// - SeeAlso: Base64EncodableImage.base64EncodedStringRepresentation()
	@nonobjc public func base64EncodedStringRepresentation() throws -> String {
		guard let data = UIImagePNGRepresentation(self) else {
			throw Base64EncodableImageError.UnsupportedBitmapData
		}
		return data.base64EncodedStringWithOptions([])
	}

}
