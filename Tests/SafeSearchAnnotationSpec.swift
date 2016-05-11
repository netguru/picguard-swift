//
// SafeSearchAnnotationSpec.swift
//
// Copyright (c) 2016 Netguru Sp. z o.o. All rights reserved.
// Licensed under the MIT License.
//

import Nimble
import Quick
import Picguard

final class SafeSearchAnnotationSpec: QuickSpec {

	override func spec() {

		describe("SafeSearchAnnotation") {

			describe("init with api representation") {

				context("with valid dictionary") {
					initWithAPIRepresentationShouldSucceed(
						value:[
							"adult": "VERY_LIKELY",
							"spoof": "VERY_UNLIKELY",
							"medical": "POSSIBLE",
							"violence": "LIKELY"
						],
						expected: SafeSearchAnnotation(
							adultContentLikelihood: .VeryLikely,
							spoofContentLikelihood: .VeryUnlikely,
							medicalContentLikelihood: .Possible,
							violentContentLikelihood: .Likely
						)
					)
				}

				describe("init with api representation") {

					context("with empty dictionary") {
						initWithAPIRepresentationShouldFail(
							value: [String: Int](),
							type: SafeSearchAnnotation.self,
							error: APIRepresentationError.MissingDictionaryKey
						)
					}

					context("with invalid representation value type") {
						initWithAPIRepresentationShouldFail(
							value: "foobar",
							type: SafeSearchAnnotation.self,
							error: APIRepresentationError.UnexpectedValueType
						)
					}
					
				}

			}

			describe("unsafe content likelihood") {

				context("when there is unknown likelihood") {

					var sut: SafeSearchAnnotation!

					beforeEach {
						sut = SafeSearchAnnotation(
							adultContentLikelihood: .Possible,
							spoofContentLikelihood: .Unknown,
							medicalContentLikelihood: .VeryLikely,
							violentContentLikelihood: .Likely
						)
					}

					it("should return unknown likelihood") {
						expect(sut.unsafeContentLikelihood).to(equal(Likelihood.Unknown))
					}

				}

				context("when there no unknown likelihood") {

					var sut: SafeSearchAnnotation!

					beforeEach {
						sut = SafeSearchAnnotation(
							adultContentLikelihood: .Possible,
							spoofContentLikelihood: .Unlikely,
							medicalContentLikelihood: .VeryLikely,
							violentContentLikelihood: .Likely
						)
					}

					it("should properly calculate likelihood") {
						expect(sut.unsafeContentLikelihood).to(equal(Likelihood.Likely))
					}
					
				}

			}

		}

	}

}
