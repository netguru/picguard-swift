//
// Base64ImageEncoderSpec.swift
//
// Copyright (c) 2016 Netguru Sp. z o.o. All rights reserved.
// Licensed under the MIT License.
//

import Nimble
import Quick
import Picguard

final class AnnotationResponseSpec: QuickSpec {

	override func spec() {

		var sut: AnnotationResponse!

		afterEach {
			sut = nil
		}

		context("when initialized with label response") {

			beforeEach {
				let bundle = NSBundle(forClass: AnnotationResponseSpec.self)
				let dataURL = bundle.URLForResource("label_response", withExtension: ".json")
				sut = AnnotationResponse(data: NSData(contentsOfURL: dataURL!)!)
			}

			it("should have 3 label annotations") {
				expect(try! sut.labelAnnotations().count).to(equal(3))
			}
		}

		context("when initialized with invalid data") {

			beforeEach {
				sut = AnnotationResponse(data: NSData())
			}

			it("should throw error when trying to parse annotations") {
				expect {
					try sut.labelAnnotations()
				}.to(throwError(AnnotationResponse.Error.ErrorParsingResponse))
			}
		}
	}
}
