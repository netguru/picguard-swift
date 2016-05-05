//
// LikelihoodSpec.swift
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
							adultLikelihood: .VeryLikely,
							spoofLikelihood: .VeryUnlikely,
							medicalLikelihood: .Possible,
							violenceLikelihood: .Likely)
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

		}

	}

}