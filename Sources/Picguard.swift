//
//  Picguard.swift
//  Picguard
//
//  Created by Lukasz Wolanczyk on 4/20/16.
//  Copyright © 2016 Netguru Sp. z o.o. All rights reserved.
//

import UIKit

public struct Picguard {

    private let imageEncoder: ImageEncoder

    public init(imageEncoder: ImageEncoder = DefaultImageEncoder()) {
        self.imageEncoder = imageEncoder
    }

    public func analyze(image: UIImage, completion: (result: Any) -> Void) {
        let tempResult = imageEncoder.base64EncodedImageString(image)
        completion(result: tempResult)
    }
}
