//
// LikelihoodSpec.swift
//
// Copyright (c) 2016 Netguru Sp. z o.o. All rights reserved.
// Licensed under the MIT License.
//

import Nimble
import Quick
import Picguard

final class LikelihoodSpec: QuickSpec {

	override func spec() {

		describe("Likelihood") {

			func initWithStringShouldSucceed(string string: String, expected: Likelihood) {
				it("should succeed to initialize") {
					expect {
						try Likelihood(string: string)
					}.to(equal(expected))
				}
			}

			func initWithStringShouldFail(string string: String) {
				it("should fail to initialize") {
					expect {
						try Likelihood(string: string)
					}.to(throwError(Likelihood.Error.InvalidStringValue))
				}
			}

			func initWithAPIRepresentationShouldSucceed(value value: APIRepresentationValue, expected: Likelihood) {
				it("should succeed to initialize") {
					expect {
						try Likelihood(APIRepresentationValue: value)
					}.to(equal(expected))
				}
			}

			func initWithAPIRepresentationShouldFail<E: ErrorType>(value value: APIRepresentationValue, error: E) {
				it("should fail to initialize") {
					expect {
						try Likelihood(APIRepresentationValue: value)
					}.to(throwError(error))
				}
			}

			describe("init with string") {

				context("with valid string representing unknown likelihood") {
					initWithStringShouldSucceed(string: "UNKNOWN", expected: .Unknown)
				}

				context("with valid string representing very unlikely likelihood") {
					initWithStringShouldSucceed(string: "VERY_UNLIKELY", expected: .VeryUnlikely)
				}

				context("with valid string representing unlikely likelihood") {
					initWithStringShouldSucceed(string: "UNLIKELY", expected: .Unlikely)
				}

				context("with valid string representing possible likelihood") {
					initWithStringShouldSucceed(string: "POSSIBLE", expected: .Possible)
				}

				context("with valid string representing likely likelihood") {
					initWithStringShouldSucceed(string: "LIKELY", expected: .Likely)
				}

				context("with valid string representing very likely likelihood") {
					initWithStringShouldSucceed(string: "VERY_LIKELY", expected: .VeryLikely)
				}

				context("with invalid string") {
					initWithStringShouldFail(string: "FOO")
				}

			}

			describe("init with api representation") {

				context("with valid string") {
					initWithAPIRepresentationShouldSucceed(value: .String("POSSIBLE"), expected: .Possible)
				}

				context("with invalid string") {
					initWithAPIRepresentationShouldFail(value: .String("BAR"), error: Likelihood.Error.InvalidStringValue)
				}

				context("with invalid representation value type") {
					initWithAPIRepresentationShouldFail(value: .Bool(true), error: APIRepresentationError.UnexpectedValueType)
				}

			}

		}

	}

}
