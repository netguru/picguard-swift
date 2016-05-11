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

			describe("init with score") {

				it("should properly initialize very unlikely likelihood") {
					expect(Likelihood(score: 0.1)).to(equal(Likelihood.VeryUnlikely))
				}

				it("should properly initialize unlikely likelihood") {
					expect(Likelihood(score: 0.3)).to(equal(Likelihood.Unlikely))
				}

				it("should properly initialize possible likelihood") {
					expect(Likelihood(score: 0.5)).to(equal(Likelihood.Possible))
				}

				it("should properly initialize likely likelihood") {
					expect(Likelihood(score: 0.7)).to(equal(Likelihood.Likely))
				}

				it("should properly initialize very likely likelihood") {
					expect(Likelihood(score: 0.9)).to(equal(Likelihood.VeryLikely))
				}

				context("when score is out of range 0...1") {

					it("should initialize unknown likelihood") {
						expect(Likelihood(score: 1.1)).to(equal(Likelihood.Unknown))
					}

				}

			}

			describe("init with api representation") {

				context("with valid string") {
					initWithAPIRepresentationShouldSucceed(value: "POSSIBLE", expected: Likelihood.Possible)
				}

				context("with invalid string") {
					initWithAPIRepresentationShouldFail(value: "BAR", type: Likelihood.self, error: Likelihood.Error.InvalidStringValue)
				}

				context("with invalid representation value type") {
					initWithAPIRepresentationShouldFail(value: true, type: Likelihood.self, error: APIRepresentationError.UnexpectedValueType)
				}

			}

			describe("score") {

				context("when likelihood is unknown") {

					it("should return score -1") {
						expect(Likelihood.Unknown.score).to(equal(-1))
					}

				}

				context("when likelihood is very unlikely") {

					it("should return score 0") {
						expect(Likelihood.VeryUnlikely.score).to(equal(0))
					}

				}

				context("when likelihood is unlikely") {

					it("should return score 0.3") {
						expect(Likelihood.Unlikely.score).to(equal(0.3))
					}

				}

				context("when likelihood is possible") {

					it("should return score 0.5") {
						expect(Likelihood.Possible.score).to(equal(0.5))
					}

				}

				context("when likelihood is likely") {

					it("should return score 0.7") {
						expect(Likelihood.Likely.score).to(equal(0.7))
					}

				}

				context("when likelihood is very likely") {

					it("should return score 1") {
						expect(Likelihood.VeryLikely.score).to(equal(1))
					}

				}

			}

		}

	}

}
