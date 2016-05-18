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

			var caughtRequest: AnnotationRequest? = nil
			var mockedResult: PicguardResult<AnnotationResponse>! = nil

			let picguard = Picguard(APIClient: MockAPIClient { request, completion in
				caughtRequest = request
				completion(mockedResult)
			})

			afterEach {
				mockedResult = nil
			}

			context("when initialized with an API key") {

				let picguard = Picguard(APIKey: "foobar")

				it("should have a default API client") {
					expect(picguard.client.dynamicType == APIClient.self).to(beTruthy())
				}

				it("should forward API key to API client") {
					let client = picguard.client as? APIClient
					expect(client?.APIKey).to(equal("foobar"))
				}

			}

			describe("unsafe content likelihood detection") {

				beforeEach {
					mockedResult = .Success(AnnotationResponse(
						faceAnnotations: nil,
						labelAnnotations: nil,
						landmarkAnnotations: nil,
						logoAnnotations: nil,
						textAnnotations: nil,
						safeSearchAnnotation: nil,
						imagePropertiesAnnotation: nil
					))
				}

				it("should send a correct request") {
					picguard.detectUnsafeContentLikelihood(image: .URL(""), completion: { _ in })
					let expectedRequest = try! AnnotationRequest(features: [.SafeSearch(maxResults: 1)], image: .URL(""))
					expect(caughtRequest).toEventually(equal(expectedRequest))
				}

				context("given a response containing safe search annotation") {

					let annotation = SafeSearchAnnotation(
						adultContentLikelihood: .Possible,
						spoofContentLikelihood: .Likely,
						medicalContentLikelihood: .VeryUnlikely,
						violentContentLikelihood: .Likely
					)

					beforeEach {
						mockedResult = .Success(AnnotationResponse(
							faceAnnotations: nil,
							labelAnnotations: nil,
							landmarkAnnotations: nil,
							logoAnnotations: nil,
							textAnnotations: nil,
							safeSearchAnnotation: annotation,
							imagePropertiesAnnotation: nil
						))
					}

					it("should calculate a correct positive likelihood") {
						var caughtResult: PicguardResult<Likelihood>! = nil
						picguard.detectUnsafeContentLikelihood(image: .URL(""), completion: { caughtResult = $0 })
						expect(caughtResult).toEventually(beSuccessful(annotation.unsafeContentLikelihood))
					}

				}

				context("given a response containing no safe search annotations") {

					beforeEach {
						mockedResult = .Success(AnnotationResponse(
							faceAnnotations: nil,
							labelAnnotations: nil,
							landmarkAnnotations: nil,
							logoAnnotations: nil,
							textAnnotations: nil,
							safeSearchAnnotation: nil,
							imagePropertiesAnnotation: nil
						))
					}

					it("should calculate unknown likelihood") {
						var caughtResult: PicguardResult<Likelihood>! = nil
						picguard.detectUnsafeContentLikelihood(image: .URL(""), completion: { caughtResult = $0 })
						expect(caughtResult).toEventually(beSuccessful(Likelihood.Unknown))
					}

				}

				context("given an erroneus response") {

					beforeEach {
						mockedResult = .Error(AnnotationError(code: 0, message: ""))
					}

					it("should forward an erroneus response") {
						var caughtResult: PicguardResult<Likelihood>! = nil
						picguard.detectUnsafeContentLikelihood(image: .URL(""), completion: { caughtResult = $0 })
						expect(caughtResult).toEventually(beErroneus())
					}

				}

			}

			describe("face presence likelihood detection") {

				beforeEach {
					mockedResult = .Success(AnnotationResponse(
						faceAnnotations: nil,
						labelAnnotations: nil,
						landmarkAnnotations: nil,
						logoAnnotations: nil,
						textAnnotations: nil,
						safeSearchAnnotation: nil,
						imagePropertiesAnnotation: nil
					))
				}

				it("should send a correct request") {
					picguard.detectFacePresenceLikelihood(image: .Data(NSData()), completion: { _ in })
					let expectedRequest = try! AnnotationRequest(features: [.Face(maxResults: 1)], image: .Data(NSData()))
					expect(caughtRequest).toEventually(equal(expectedRequest))
				}

				context("given a response containing face annotation") {

					let annotation = try! FaceAnnotation(
						boundingPolygon: BoundingPolygon(vertices: []),
						skinBoundingPolygon: BoundingPolygon(vertices: []),
						landmarks: [],
						rollAngle: 0,
						panAngle: 0,
						tiltAngle: 0,
						detectionConfidence: 0.75,
						landmarkingConfidence: 0.5,
						joyLikelihood: .Unknown,
						sorrowLikelihood: .Unknown,
						angerLikelihood: .Unknown,
						surpriseLikelihood: .Unknown,
						underExposedLikelihood: .Unknown,
						blurredLikelihood: .Unknown,
						headwearLikelihood: .Unknown
					)

					beforeEach {
						mockedResult = .Success(AnnotationResponse(
							faceAnnotations: [annotation],
							labelAnnotations: nil,
							landmarkAnnotations: nil,
							logoAnnotations: nil,
							textAnnotations: nil,
							safeSearchAnnotation: nil,
							imagePropertiesAnnotation: nil
						))
					}

					it("should calculate a correct positive likelihood") {
						var caughtResult: PicguardResult<Likelihood>! = nil
						picguard.detectFacePresenceLikelihood(image: .Data(NSData()), completion: { caughtResult = $0 })
						expect(caughtResult).toEventually(beSuccessful(try! Likelihood(score: annotation.detectionConfidence)))
					}

				}

				context("given a response containing no face annotations") {

					beforeEach {
						mockedResult = .Success(AnnotationResponse(
							faceAnnotations: [],
							labelAnnotations: nil,
							landmarkAnnotations: nil,
							logoAnnotations: nil,
							textAnnotations: nil,
							safeSearchAnnotation: nil,
							imagePropertiesAnnotation: nil
						))
					}

					it("should calculate unknown likelihood") {
						var caughtResult: PicguardResult<Likelihood>! = nil
						picguard.detectFacePresenceLikelihood(image: .Data(NSData()), completion: { caughtResult = $0 })
						expect(caughtResult).toEventually(beSuccessful(Likelihood.Unknown))
					}

				}

				context("given an erroneus response") {

					beforeEach {
						mockedResult = .Error(AnnotationError(code: 0, message: ""))
					}

					it("should forward an erroneus response") {
						var caughtResult: PicguardResult<Likelihood>! = nil
						picguard.detectFacePresenceLikelihood(image: .Data(NSData()), completion: { caughtResult = $0 })
						expect(caughtResult).toEventually(beErroneus())
					}

				}

			}

			describe("raw annotation") {

				beforeEach {
					mockedResult = .Success(AnnotationResponse(
						faceAnnotations: nil,
						labelAnnotations: nil,
						landmarkAnnotations: nil,
						logoAnnotations: nil,
						textAnnotations: nil,
						safeSearchAnnotation: nil,
						imagePropertiesAnnotation: nil
					))
				}

				it("should send a correct request") {
					picguard.annotate(image: .Data(NSData()), features: [.Label(maxResults: 1)], completion: { _ in })
					let expectedRequest = try! AnnotationRequest(features: [.Label(maxResults: 1)], image: .Data(NSData()))
					expect(caughtRequest).toEventually(equal(expectedRequest))
				}

				context("given a successful response") {

					let response = AnnotationResponse(
						faceAnnotations: nil,
						labelAnnotations: nil,
						landmarkAnnotations: nil,
						logoAnnotations: nil,
						textAnnotations: nil,
						safeSearchAnnotation: nil,
						imagePropertiesAnnotation: nil
					)

					beforeEach {
						mockedResult = .Success(response)
					}

					it("should calculate a correct positive likelihood") {
						var caughtResult: PicguardResult<AnnotationResponse>! = nil
						picguard.annotate(image: .Data(NSData()), features: [.Landmark(maxResults: 1)], completion: { caughtResult = $0 })
						expect(caughtResult).toEventually(beSuccessful(response))
					}

				}

				context("given an erroneus response") {

					beforeEach {
						mockedResult = .Error(AnnotationError(code: 0, message: ""))
					}

					it("should forward an erroneus response") {
						var caughtResult: PicguardResult<AnnotationResponse>! = nil
						picguard.annotate(image: .Data(NSData()), features: [.Text], completion: { caughtResult = $0 })
						expect(caughtResult).toEventually(beErroneus())
					}

				}

			}

		}

	}

}

// MARK: -

private final class MockAPIClient: APIClientType {

	private typealias PerformRequestClosureType = (AnnotationRequest, (PicguardResult<AnnotationResponse>) -> Void) -> Void

	private let performRequestClosure: PerformRequestClosureType

	private init(_ performRequestClosure: PerformRequestClosureType) {
		self.performRequestClosure = performRequestClosure
	}

	private func perform(request request: AnnotationRequest, completion: (PicguardResult<AnnotationResponse>) -> Void) {
		performRequestClosure(request, completion)
	}

}
