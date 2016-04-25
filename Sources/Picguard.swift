//
//  Picguard.swift
//  Picguard
//
//  Created by Lukasz Wolanczyk on 4/20/16.
//  Copyright © 2016 Netguru Sp. z o.o. All rights reserved.
//

import UIKit

public struct Picguard {

    private let imageEncoder: ImageEncoding

    public init(imageEncoder: ImageEncoding = Base64ImageEncoder()) {
        self.imageEncoder = imageEncoder
    }

    public func analyze(image: UIImage, completion: (result: Any) -> Void) throws {
        let tempResult = try imageEncoder.encode(image: image)
        completion(result: tempResult)
    }
}
