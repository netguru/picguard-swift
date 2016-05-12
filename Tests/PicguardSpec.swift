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

				var capturedResult: PicguardResult<Likelihood>!
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

				context("when completion result has no safe search annotation") {

					beforeEach {
						mockClient.lastCompletion(
							PicguardResult<AnnotationResponse>.Success(
								AnnotationResponse.init(
									faceAnnotations: nil,
									labelAnnotations: nil,
									landmarkAnnotations: nil,
									logoAnnotations: nil,
									textAnnotations: nil,
									safeSearchAnnotation: nil,
									imagePropertiesAnnotation: nil
								)
							)
						)
					}

					it("should return result with unknown likelihood"){
						guard case .Success(let likelihood) = capturedResult! else {
							fail("failed to get value")
							return
						}
						expect(likelihood).to(equal(try! Likelihood(string: "UNKNOWN")))
					}

				}

				context("when completion result has safe search annotation") {

					beforeEach {
						mockClient.lastCompletion(
							PicguardResult<AnnotationResponse>.Success(
								AnnotationResponse.init(
									faceAnnotations: nil,
									labelAnnotations: nil,
									landmarkAnnotations: nil,
									logoAnnotations: nil,
									textAnnotations: nil,
									safeSearchAnnotation: SafeSearchAnnotation(
										adultContentLikelihood: .Likely,
										spoofContentLikelihood: .Likely,
										medicalContentLikelihood: .Likely,
										violentContentLikelihood: .Likely
									),
									imagePropertiesAnnotation: nil
								)
							)
						)
					}

					it("should return result with proper likelihood"){
						guard case .Success(let likelihood) = capturedResult! else {
							fail("failed to get value")
							return
						}
						expect(likelihood).to(equal(Likelihood.Likely))
					}

				}

				context("when completion result has an error") {

					beforeEach {
						mockClient.lastCompletion(PicguardResult<AnnotationResponse>.Error(APIClient.Error.NoResponse))
					}

					it("should return result with proper error"){
						guard
							case .Error(let error) = capturedResult!,
							case .NoResponse = error as! APIClient.Error
						else {
							fail("failed to get error")
							return
						}
					}
					
				}
				
			}

		}

	}

}

private final class MockAPIClient: APIClientType {

	var lastRequest: AnnotationRequest!
	var lastCompletion: ((PicguardResult<AnnotationResponse>) -> Void)!

	func perform(request request: AnnotationRequest, completion: (PicguardResult<AnnotationResponse>) -> Void) {
		lastRequest = request
		lastCompletion = completion
	}

}
