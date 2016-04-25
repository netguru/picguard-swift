//
// ImageEncoding.swift
//
// Copyright (c) 2016 Netguru Sp. z o.o. All rights reserved.
// Licensed under the MIT License.
//

import UIKit

public protocol ImageEncoding {
	func encode(image image: UIImage) throws -> String
}
