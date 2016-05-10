//
// ColorInformationSpec.swift
//
// Copyright (c) 2016 Netguru Sp. z o.o. All rights reserved.
// Licensed under the MIT License.
//

import Nimble
import Quick
import Picguard

final class ColorInformationSpec: QuickSpec {

	override func spec() {

		describe("ColorInformation") {

			describe("init with raw values") {

				context("with all values being valid") {

					it("should succeed") {
						expect {
							try ColorInformation(
								color: Color(red: 0.1, green: 0.2, blue: 0.3),
								score: 0.2,
								pixelFraction: 0.3
							)
						}.toNot(throwError())
					}

				}

				context("with invalid score ") {

					it("should fail") {
						expect {
							try ColorInformation(
								color: Color(red: 0.1, green: 0.2, blue: 0.3),
								score: 1.2,
								pixelFraction: 0.3
							)
						}.to(throwError(ColorInformation.Error.InvalidScore))
					}

				}

				context("with invalid pixel fraction ") {

					it("should fail") {
						expect {
							try ColorInformation(
								color: Color(red: 0.1, green: 0.2, blue: 0.3),
								score: 0.2,
								pixelFraction: 1.3
							)
						}.to(throwError(ColorInformation.Error.InvalidPixelFraction))
					}
					
				}

			}

			describe("init with api representation") {

				context("with valid dictionary") {
					initWithAPIRepresentationShouldSucceed(
						value: [
							"score": 0.2,
							"pixelFraction": 0.3,
							"color": ["red": 51, "green": 51, "blue": 51]
						],
						expected: try! ColorInformation(
							color: Color(red: 0.2, green: 0.2, blue: 0.2),
							score: 0.2,
							pixelFraction: 0.3
						)
					)
				}

				context("with invalid representation value type") {
					initWithAPIRepresentationShouldFail(
						value: "foobar",
						type: ColorInformation.self,
						error: APIRepresentationError.UnexpectedValueType
					)
				}

			}

		}
		
	}
	
}
