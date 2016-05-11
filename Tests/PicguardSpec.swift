//
// PicguardSpec.swift
//
// Copyright (c) 2016 Netguru Sp. z o.o. All rights reserved.
// Licensed under the MIT License.
//

import Nimble
import Quick
import Picguard

final class PicguardSpec: QuickSpec {

	override func spec() {

		var sut: Picguard!

		beforeEach {
			sut = Picguard(APIKey: "fixture api key")
		}

		afterEach {
			sut = nil
		}

		it("should have API client") {
			expect(sut.client.dynamicType == APIClient.self).to(beTruthy())
		}

		describe("detect unsafe content") {

			var mockClient: MockAPIClient!
			var capturedResult: Result<Likelihood>!
			var image: UIImage!

			beforeEach {
				image = UIImage()
				mockClient = MockAPIClient()
				sut.client = mockClient
				sut.detectUnsafeContent(image: UIImage(), completion: { result in
					capturedResult = result
				})
			}


			it("perform proper request") {
				expect(mockClient.lastRequest).to(equal(try! AnnotationRequest(features: Set([.SafeSearch(maxResults: 1)]), image: .Image(image)))
				)
			}

		}

	}

}

private final class MockAPIClient: APIClientType {

	var lastRequest: AnnotationRequest!
	var lastCompletion: ((AnnotationResult) -> Void)!

	func perform(request request: AnnotationRequest, completion: (AnnotationResult) -> Void) {
		lastRequest = request
		lastCompletion = completion
	}

}
