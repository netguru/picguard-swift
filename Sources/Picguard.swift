//
// Picguard.swift
//
// Copyright (c) 2016 Netguru Sp. z o.o. All rights reserved.
// Licensed under the MIT License.
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
