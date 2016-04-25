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

            beforeEach {
                let view = UIView(frame: CGRect(x: 0, y: 0, width: 1, height: 1))
                let image = view.imageFromView()
                encodedImage = try! sut.encode(image: image)
            }

            it("should return base64 encoded image string") {
                let decodedData = NSData(base64EncodedString: encodedImage, options: [])
                let view = UIView(frame: CGRect(x: 0, y: 0, width: 1, height: 1))
                expect(decodedData).to(equal(UIImagePNGRepresentation(view.imageFromView())))
            }
        }
    }
}

// MARK: - Image from view

private extension UIView {

    func imageFromView() -> UIImage {
        UIGraphicsBeginImageContext(self.bounds.size);
        self.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return image
    }
}