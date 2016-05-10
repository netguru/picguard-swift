//
// ColorSpec.swift
//
// Copyright (c) 2016 Netguru Sp. z o.o. All rights reserved.
// Licensed under the MIT License.
//

import Nimble
import Quick
import Picguard

final class ColorSpec: QuickSpec {

	override func spec() {

		describe("Color") {

			describe("init with raw values") {

				context("with all color components being valid") {

					it("should succeed") {
						expect {
							try Color(red: 0.1, green: 0.2, blue: 0.3)
						}.toNot(throwError())
					}

				}

				context("with invalid red color component") {

					it("should fail") {
						expect {
							try Color(red: 1.1, green: 0.2, blue: 0.3)
						}.to(throwError(Color.Error.InvalidColorComponent))
					}

				}

				context("with invalid green color component") {

					it("should fail") {
						expect {
							try Color(red: 0.1, green: -0.2, blue: 0.3)
						}.to(throwError(Color.Error.InvalidColorComponent))
					}

				}

				context("with invalid blue color component") {

					it("should fail") {
						expect {
							try Color(red: 0.1, green: 0.2, blue: -0.01)
						}.to(throwError(Color.Error.InvalidColorComponent))
					}

				}

			}

			describe("init with api representation") {

				context("with valid dictionary") {
					initWithAPIRepresentationShouldSucceed(
						value: ["red": 51, "green": 102, "blue": 204,],
						expected: try! Color(red: 0.2, green: 0.4,blue: 0.8)
					)
				}

				context("with invalid representation value type") {
					initWithAPIRepresentationShouldFail(
						value: "foobar",
						type: Color.self,
						error: APIRepresentationError.UnexpectedValueType
					)
				}
				
			}

		}

	}

}
