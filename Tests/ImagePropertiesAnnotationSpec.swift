//
// ImagePropertiesAnnotationSpec.swift
//
// Copyright (c) 2016 Netguru Sp. z o.o. All rights reserved.
// Licensed under the MIT License.
//

import Nimble
import Quick
import Picguard

final class ImagePropertiesAnnotationSpec: QuickSpec {

	override func spec() {

		describe("ImagePropertiesAnnotation") {

			describe("init with api representation") {

				context("with valid dictionary") {
					initWithAPIRepresentationShouldSucceed(
						value: ["dominantColors":
							["colors":
								[
									[
										"score": 0.2,
										"pixelFraction": 0.3,
										"color": ["red": 51, "green": 102, "blue": 153]
									]
								]
							]
						],
						expected: try! ImagePropertiesAnnotation(
							dominantColors: [
								ColorInformation(
									color: Color(red: 0.2, green: 0.4, blue: 0.6),
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
						type: ImagePropertiesAnnotation.self,
						error: APIRepresentationError.UnexpectedValueType
					)
				}

			}
			
		}
		
	}
	
}
