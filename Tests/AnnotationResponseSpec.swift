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
				let data = NSData(contentsOfURL: dataURL!)
				let JSONDictionary = try! NSJSONSerialization.JSONObjectWithData(data!, options: []) as! [String: [AnyObject]]
				let response = JSONDictionary["responses"]!.first
				let value = try! APIRepresentationValue(value: response!)
				sut = try! AnnotationResponse(APIRepresentationValue: value)
			}

			it("should have 3 label annotations") {
				expect(sut.labelAnnotations?.count).to(equal(3))
			}
		}
	}
}
