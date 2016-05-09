//
// LocationSpec.swift
//
// Copyright (c) 2016 Netguru Sp. z o.o. All rights reserved.
// Licensed under the MIT License.
//

import Nimble
import Quick
import Picguard

final class LocationSpec: QuickSpec {

	override func spec() {

		describe("Location") {

			func initWithRawValuesShouldSucceed(values values: (latitude: Double, longitude: Double)) {
				it("should succeed to initialize") {
					expect {
						try Location(latitude: values.latitude, longitude: values.longitude)
					}.toNot(throwError())
				}
			}

			func initWithRawValuesShouldFail<E: ErrorType>(values values: (latitude: Double, longitude: Double), error: E) {
				it("should fail to initialize") {
					expect {
						try Location(latitude: values.latitude, longitude: values.longitude)
					}.to(throwError(error))
				}
			}

			describe("init with raw values") {

				context("with valid latitude and longitude") {
					initWithRawValuesShouldSucceed(values: (latitude: 0, longitude: 0))
				}

				context("with invalid latitude") {
					initWithRawValuesShouldFail(values: (latitude: 120, longitude: 0), error: Location.Error.InvalidLatitude)
				}

				context("with invalid longitude") {
					initWithRawValuesShouldFail(values: (latitude: 0, longitude: 200), error: Location.Error.InvalidLongitude)
				}

			}

			describe("init with api representation") {

				context("with valid dictionary") {
					initWithAPIRepresentationShouldSucceed(value: [
						"latLng": [
							"latitude": 1.234,
							"longitude": 5.678,
						],
					], expected: try! Location(
						latitude: 1.234,
						longitude: 5.678
					))
				}

				context("with empty root dictionary") {
					initWithAPIRepresentationShouldFail(
						value: [String: AnyObject](),
						type: Location.self,
						error: APIRepresentationError.MissingDictionaryKey
					)
				}

				context("with empty nested dictionary") {
					initWithAPIRepresentationShouldFail(
						value: ["latLng": [String: AnyObject]()],
						type: Location.self,
						error: APIRepresentationError.MissingDictionaryKey
					)
				}

				context("with invalid root representation value type") {
					initWithAPIRepresentationShouldFail(
						value: "foobar",
						type: Location.self,
						error: APIRepresentationError.UnexpectedValueType
					)
				}

				context("with invalid nested representation value type") {
					initWithAPIRepresentationShouldFail(
						value: ["latLng": "bazqux"],
						type: Location.self,
						error: APIRepresentationError.UnexpectedValueType
					)
				}

			}

		}

	}

}
