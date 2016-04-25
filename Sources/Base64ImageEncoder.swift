//
//  Base64ImageEncoder.swift
//  Picguard
//
//  Created by Adrian Kashivskyy on 21.04.2016.
//  Copyright © 2016 Netguru Sp. z o.o. All rights reserved.
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
