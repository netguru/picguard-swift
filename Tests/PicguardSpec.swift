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

		describe("Picguard") {

			var mockClient: MockAPIClient!
			var sut: Picguard!

			beforeEach {
				mockClient = MockAPIClient()
				sut = Picguard(APIClient: mockClient)
			}

			afterEach {
				sut = nil
			}

			context("when initialized with API key") {

				var sut: Picguard!

				beforeEach {
					sut = Picguard(APIKey: "foo")
				}

				it("should have proper API client") {
					expect(sut.client.dynamicType == APIClient.self).to(beTruthy())
				}
			}

			describe("detect unsafe content") {

				var capturedResult: Result<Likelihood>!
				var image: UIImage!

				beforeEach {
					image = UIImage()
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

}

private final class MockAPIClient: APIClientType {

	var lastRequest: AnnotationRequest!
	var lastCompletion: ((AnnotationResult) -> Void)!

	func perform(request request: AnnotationRequest, completion: (AnnotationResult) -> Void) {
		lastRequest = request
		lastCompletion = completion
	}

}
