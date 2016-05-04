//
// Base64ImageEncoderSpec.swift
//
// Copyright (c) 2016 Netguru Sp. z o.o. All rights reserved.
// Licensed under the MIT License.
//

import Nimble
import Quick
import Picguard

final class APIClientSpec: QuickSpec {

	override func spec() {

		var sut: APIClient!
		var mockSession: MockURLSession!

		beforeEach {
			mockSession = MockURLSession()
			sut = APIClient(APIKey: "fixtureAPIKey", encoder: MockImageEncoder(), session: mockSession)
		}

		afterEach {
			sut = nil
		}

		describe("perform request") {

			var annotationResult: AnnotationResult!

			beforeEach {
				let features = Set([AnnotationRequest.Feature.Label(maxResults: 1)])
				let image = AnnotationRequest.Image.Image(UIImage())
				let request = try! AnnotationRequest.init(features: features, image: image)
				try! sut.perform(request: request) { result in
					annotationResult = result
				}
			}

			describe("created data task") {

				var mockDataTask: MockURLSessionDataTask!

				beforeEach {
					mockDataTask = mockSession.lastCreatedDataTask
				}

				it("should be resumed") {
					expect(mockDataTask.hasBeenResumed).to(beTruthy())
				}
			}

			describe("data task request") {

				var dataTaskRequest: NSURLRequest!

				beforeEach {
					dataTaskRequest = mockSession.dataTaskRequest
				}

				it("should have proper URL") {
					expect(dataTaskRequest.URL).to(equal(NSURL(string: "https://vision.googleapis.com/v1/images:annotate?key=fixtureAPIKey")))
				}

				it("should have POST HTTP method") {
					expect(dataTaskRequest.HTTPMethod).to(equal("POST"))
				}

				it("should have proper HTTP header fields") {
					expect(dataTaskRequest.allHTTPHeaderFields).to(equal(["Content-Type": "application/json"]))
				}
			}

			describe("data task completion") {

				var dataTaskCompletionHandler: ((NSData?, NSURLResponse?, NSError?) -> Void)!

				beforeEach {
					dataTaskCompletionHandler = mockSession.dataTaskCompletionHandler
				}

				context("when response status code is not 200") {

					beforeEach {
						let response = NSHTTPURLResponse(URL: NSURL(), statusCode: 500, HTTPVersion: nil, headerFields: nil)
						dataTaskCompletionHandler(nil, response, nil)
					}

					it("should return result with error BadServerResponse") {
						guard let annotationResult = annotationResult else {
							return
						}
						var apiClientError: APIClientError!
						switch annotationResult {
						case .Error(let error): apiClientError = error as! APIClientError
						default: break
						}
						expect(apiClientError).to(equal(APIClientError.BadServerResponse))
					}
				}

				context("when there is an error") {

					var error: NSError!

					beforeEach {
						let response = NSHTTPURLResponse(URL: NSURL(), statusCode: 200, HTTPVersion: nil, headerFields: nil)
						error = NSError(domain: "", code: 1, userInfo: nil)
						dataTaskCompletionHandler(nil, response, error)
					}

					it("should return result with given error") {
						guard let annotationResult = annotationResult else {
							return
						}
						var errorType: ErrorType!
						switch annotationResult {
						case .Error(let error): errorType = error
						default: break
						}
						expect(errorType as? NSError).to(equal(error))
					}
				}

				context("when there is no error") {

					var data: NSData!

					beforeEach {
						let response = NSHTTPURLResponse(URL: NSURL(), statusCode: 200, HTTPVersion: nil, headerFields: nil)
						data = NSData()
						dataTaskCompletionHandler(data, response, nil)
					}

					it("should return result annotation response") {
						guard let annotationResult = annotationResult else {
							return
						}
						var annotationResponse: AnnotationResponse!
						switch annotationResult {
						case .Success(let response): annotationResponse = response
						default: break
						}
						expect(annotationResponse.data).to(equal(data))
					}
				}
			}
		}
	}
}

private final class MockURLSession: NSURLSession {

	var lastCreatedDataTask: MockURLSessionDataTask!
	var dataTaskRequest: NSURLRequest!
	var dataTaskCompletionHandler: ((NSData?, NSURLResponse?, NSError?) -> Void)!

	override func dataTaskWithRequest(request: NSURLRequest,
	                                  completionHandler: (NSData?, NSURLResponse?, NSError?) -> Void)
		-> NSURLSessionDataTask {
			dataTaskRequest = request
			dataTaskCompletionHandler = completionHandler
			lastCreatedDataTask = MockURLSessionDataTask()
			return lastCreatedDataTask
	}
}

private final class MockURLSessionDataTask: NSURLSessionDataTask {

	var hasBeenResumed = false

	override func resume() {
		hasBeenResumed = true
	}
}
