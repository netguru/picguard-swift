//
//  PicguardSpec.swift
//  Picguard
//
//  Created by Lukasz Wolanczyk on 4/20/16.
//  Copyright © 2016 Netguru Sp. z o.o. All rights reserved.
//

import Nimble
import Quick
import Picguard

final class PicguardSpec: QuickSpec {

    override func spec() {

        var sut: Picguard!

        beforeEach {
            sut = Picguard(imageEncoder: MockImageEncoder())
        }

        afterEach {
            sut = nil
        }

        describe("analyze") {

            var capturedResult: Any!

            beforeEach {
                sut.analyze(UIImage()) { result in
                    capturedResult = result
                }
            }

            it("should return base64 encoded image string for now") {
                expect(capturedResult as? String).to(equal("dummy base64 encoded image string"))
            }
        }
    }
}

private struct MockImageEncoder: ImageEncoder {
    func base64EncodedImageString(image: UIImage) -> String? {
        return "dummy base64 encoded image string"
    }
}
