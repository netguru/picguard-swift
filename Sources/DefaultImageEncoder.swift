//
//  DefaultImageEncoder.swift
//  Picguard
//
//  Created by Lukasz Wolanczyk on 4/20/16.
//  Copyright © 2016 Netguru Sp. z o.o. All rights reserved.
//

import UIKit

struct DefaultImageEncoder {
}

extension DefaultImageEncoder: ImageEncoder {
    func base64EncodedImageString(image: UIImage) -> String? {
        return UIImagePNGRepresentation(image)?.base64EncodedStringWithOptions([])
    }
}
