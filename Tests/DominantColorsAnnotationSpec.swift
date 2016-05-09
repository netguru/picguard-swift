//
//  DominantColorsAnnotationSpec.swift
//
// Copyright (c) 2016 Netguru Sp. z o.o. All rights reserved.
// Licensed under the MIT License.
//

import Nimble
import Quick
import Picguard

final class DominantColorsAnnotationSpec: QuickSpec {

	override func spec() {

		describe("DominantColorsAnnotation") {

			describe("init with api representation") {

				context("with valid dictionary") {
					initWithAPIRepresentationShouldSucceed(
						value: ["colors":
							[
								[
									"score": 0.2,
									"pixelFraction": 0.3,
									"color": ["red": 1, "green": 2, "blue": 3]
								]
							]
						],
						expected: try! DominantColorsAnnotation(colors:
							[
								ColorInfo(
									color: Color(red: 1, green: 2, blue: 3),
									score: 0.2,
									pixelFraction: 0.3
								)
							]
						)
					)
				}

				context("with invalid representation value type") {
					initWithAPIRepresentationShouldFail(
						value: "foobar",
						type: DominantColorsAnnotation.self,
						error: APIRepresentationError.UnexpectedValueType
					)
				}
				
			}

		}
		
	}
	
}