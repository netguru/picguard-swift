//
// LogoAnnotationSpec.swift
//
// Copyright (c) 2016 Netguru Sp. z o.o. All rights reserved.
// Licensed under the MIT License.
//

import Nimble
import Quick
import Picguard

final class LogoAnnotationSpec: QuickSpec {

	override func spec() {

		describe("LogoAnnotation") {

			func initWithRawValuesShouldSucceed(score score: Double) {
				it("should succeed to initialize") {
					expect {
						try LogoAnnotation(
							entityIdentifier: "foo",
							boundingPolygon: BoundingPolygon(vertices: []),
							description: "bar",
							score: score
						)
					}.toNot(throwError())
				}
			}

			func initWithRawValuesShouldFail<E: ErrorType>(score score: Double, error: E) {
				it("should fail to initialize") {
					expect {
						try LogoAnnotation(
							entityIdentifier: "foo",
							boundingPolygon: BoundingPolygon(vertices: []),
							description: "bar",
							score: score
						)
					}.to(throwError(error))
				}
			}

			describe("init with raw values") {

				context("with valid score") {
					initWithRawValuesShouldSucceed(score: 0.5)
				}

				context("with score less than zero") {
					initWithRawValuesShouldFail(score: -1, error: LogoAnnotation.Error.InvalidScore)
				}

				context("with score greater than one") {
					initWithRawValuesShouldFail(score: 2, error: LogoAnnotation.Error.InvalidScore)
				}

			}

			describe("init with api representation") {

				context("with valid dictionary") {
					initWithAPIRepresentationShouldSucceed(value: [
						"mid": "foo",
						"description": "bar",
						"score": 0.12345,
						"boundingPoly": [
							"vertices": [
								["x": 1, "y": 2],
								["x": 3, "y": 4],
							],
						],
					], expected: try! LogoAnnotation(
						entityIdentifier: "foo",
						boundingPolygon: BoundingPolygon(vertices: [Vertex(x: 1, y: 2), Vertex(x: 3, y: 4)]),
						description: "bar",
						score: 0.12345
					))
				}

				context("with empty dictionary") {
					initWithAPIRepresentationShouldFail(
						value: [String: AnyObject](),
						type: LogoAnnotation.self,
						error: APIRepresentationError.MissingDictionaryKey
					)
				}

				context("with invalid representation value type") {
					initWithAPIRepresentationShouldFail(
						value: "foobar",
						type: LogoAnnotation.self,
						error: APIRepresentationError.UnexpectedValueType
					)
				}
				
			}
			
		}
		
	}
	
}