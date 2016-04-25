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
                try! sut.analyze(UIImage()) { result in
                    capturedResult = result
                }
            }

            it("should return encoded image") {
                expect(capturedResult as? String).to(equal("fixture encoded image"))
            }
        }
    }
}

private struct MockImageEncoder: ImageEncoding {

    func encode(image image: UIImage) throws -> String {
        return "fixture encoded image"
    }
}
