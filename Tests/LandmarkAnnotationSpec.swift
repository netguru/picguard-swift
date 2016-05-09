//
// LandmarkAnnotationSpec.swift
//
// Copyright (c) 2016 Netguru Sp. z o.o. All rights reserved.
// Licensed under the MIT License.
//

import Nimble
import Quick
import Picguard

final class LandmarkAnnotationSpec: QuickSpec {

	override func spec() {

		describe("LandmarkAnnotation") {

			func initWithRawValuesShouldSucceed(score score: Double) {
				it("should succeed to initialize") {
					expect {
						try LandmarkAnnotation(
							entityIdentifier: "foo",
							boundingPolygon: BoundingPolygon(vertices: []),
							description: "bar",
							score: score,
							locations: []
						)
					}.toNot(throwError())
				}
			}

			func initWithRawValuesShouldFail<E: ErrorType>(score score: Double, error: E) {
				it("should fail to initialize") {
					expect {
						try LandmarkAnnotation(
							entityIdentifier: "foo",
							boundingPolygon: BoundingPolygon(vertices: []),
							description: "bar",
							score: score,
							locations: []
						)
					}.to(throwError(error))
				}
			}

			describe("init with raw values") {

				context("with valid score") {
					initWithRawValuesShouldSucceed(score: 0.5)
				}

				context("with score less than zero") {
					initWithRawValuesShouldFail(score: -1, error: LandmarkAnnotation.Error.InvalidScore)
				}

				context("with score greater than one") {
					initWithRawValuesShouldFail(score: 2, error: LandmarkAnnotation.Error.InvalidScore)
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
						"locations": [
							["latLng": ["latitude": 5, "longitude": 6]],
							["latLng": ["latitude": 7, "longitude": 8]],
						],
					], expected: try! LandmarkAnnotation(
						entityIdentifier: "foo",
						boundingPolygon: BoundingPolygon(vertices: [Vertex(x: 1, y: 2), Vertex(x: 3, y: 4)]),
						description: "bar",
						score: 0.12345,
						locations: [Location(latitude: 5, longitude: 6), Location(latitude: 7, longitude: 8)]
					))
				}

				context("with empty dictionary") {
					initWithAPIRepresentationShouldFail(
						value: [String: AnyObject](),
						type: LandmarkAnnotation.self,
						error: APIRepresentationError.MissingDictionaryKey
					)
				}

				context("with invalid representation value type") {
					initWithAPIRepresentationShouldFail(
						value: "foobar",
						type: LandmarkAnnotation.self,
						error: APIRepresentationError.UnexpectedValueType
					)
				}

			}

		}

	}

}
