//
//  Base64ImageEncoderSpec.swift
//  Picguard
//
//  Created by Lukasz Wolanczyk on 4/25/16.
//  Copyright © 2016 Netguru Sp. z o.o. All rights reserved.
//

import Nimble
import Quick
import Picguard

final class Base64ImageEncoderSpec: QuickSpec {

    override func spec() {

        var sut: Base64ImageEncoder!

        beforeEach {
            sut = Base64ImageEncoder()
        }

        afterEach {
            sut = nil
        }

        describe("analyze") {

            var encodedImage: String!
            var image: UIImage!

            beforeEach {
                image = UIImage(size: CGSize(width: 1, height: 1), color: .yellowColor())
                encodedImage = try! sut.encode(image: image)
            }

            it("should return base64 encoded image string") {
                let decodedData = NSData(base64EncodedString: encodedImage, options: [])
                expect(decodedData).to(equal(UIImagePNGRepresentation(image)))
            }
        }
    }
}

// MARK: - Image from view

private extension UIImage {

    convenience init(size: CGSize, color: UIColor) {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        CGContextSetFillColorWithColor(context, color.CGColor)
        CGContextFillRect(context, rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        let renderedImage = image.imageWithRenderingMode(.AlwaysOriginal)
        self.init(data: UIImagePNGRepresentation(renderedImage)!)!
    }
}
