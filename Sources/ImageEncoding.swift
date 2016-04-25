//
//  ImageEncoding.swift
//  Picguard
//
//  Created by Lukasz Wolanczyk on 4/20/16.
//  Copyright © 2016 Netguru Sp. z o.o. All rights reserved.
//

import UIKit

public protocol ImageEncoding {
	func encode(image image: UIImage) throws -> String
}
