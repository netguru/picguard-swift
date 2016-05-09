//
//  ColorInfoSpec.swift
//
// Copyright (c) 2016 Netguru Sp. z o.o. All rights reserved.
// Licensed under the MIT License.
//

import Nimble
import Quick
import Picguard

final class ColorInfoSpec: QuickSpec {

	override func spec() {

		describe("ColorInfo") {

			describe("init with raw values") {

				context("with all values being valid") {

					it("should succeed") {
						expect {
							try ColorInfo(
								color: Color(red: 1, green: 2, blue: 3),
								score: 0.2,
								pixelFraction: 0.3
							)
						}.toNot(throwError())
					}

				}

				context("with invalid score ") {

					it("should fail") {
						expect {
							try ColorInfo(
								color: Color(red: 1, green: 2, blue: 3),
								score: 1.2,
								pixelFraction: 0.3
							)
						}.to(throwError(ColorInfo.Error.InvalidScore))
					}

				}

				context("with invalid pixel fraction ") {

					it("should fail") {
						expect {
							try ColorInfo(
								color: Color(red: 1, green: 2, blue: 3),
								score: 0.2,
								pixelFraction: 1.3
							)
						}.to(throwError(ColorInfo.Error.InvalidPixelFraction))
					}
					
				}

			}

			describe("init with api representation") {

				context("with valid dictionary") {
					initWithAPIRepresentationShouldSucceed(
						value: [
							"score": 0.2,
							"pixelFraction": 0.3,
							"color": ["red": 1, "green": 2, "blue": 3]
						],
						expected: try! ColorInfo(
							color: Color(red: 1, green: 2, blue: 3),
							score: 0.2,
							pixelFraction: 0.3
						)
					)
				}

				context("with invalid representation value type") {
					initWithAPIRepresentationShouldFail(
						value: "foobar",
						type: ColorInfo.self,
						error: APIRepresentationError.UnexpectedValueType
					)
				}

			}

		}
		
	}
	
}