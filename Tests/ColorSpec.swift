//
//  ColorSpec.swift
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
							try Color(red: 33, green: 44, blue: 55)
						}.toNot(throwError())
					}

				}

				context("with invalid red color component") {

					it("should fail") {
						expect {
							try Color(red: 333, green: 44, blue: 55)
						}.to(throwError(Color.Error.InvalidColorComponent))
					}

				}

				context("with invalid green color component") {

					it("should fail") {
						expect {
							try Color(red: 33, green: 444, blue: 55)
							}.to(throwError(Color.Error.InvalidColorComponent))
					}

				}

				context("with invalid blue color component") {

					it("should fail") {
						expect {
							try Color(red: 33, green: 44, blue: 555)
							}.to(throwError(Color.Error.InvalidColorComponent))
					}

				}

			}

			describe("init with api representation") {

				context("with valid dictionary") {
					initWithAPIRepresentationShouldSucceed(
						value: ["red": 33, "green": 44, "blue": 55,],
						expected: try! Color(red: 33, green: 44,blue: 55)
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