//
//  ImagePropertiesAnnotationSpec.swift
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
										"color": ["red": 1, "green": 2, "blue": 3]
									]
								]
							]
						],
						expected: try! ImagePropertiesAnnotation(
							dominantColorsAnnotation: DominantColorsAnnotation(
								colors: [
									ColorInfo(
										color: Color(red: 1, green: 2, blue: 3),
										score: 0.2,
										pixelFraction: 0.3
									)
								]
							)
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