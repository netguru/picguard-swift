//
// AnnotationResponseSpec.swift
//
// Copyright (c) 2016 Netguru Sp. z o.o. All rights reserved.
// Licensed under the MIT License.
//

import Nimble
import Quick
import Picguard

final class AnnotationResponseSpec: QuickSpec {

	override func spec() {

		describe("AnnotationResponse") {

			describe("init with api representation") {

				context("with non empty dictionary") {
					initWithAPIRepresentationShouldSucceed(
						value: [
							"faceAnnotations": [AnyObject](),
							"labelAnnotations": [AnyObject](),
							"landmarkAnnotations": [AnyObject](),
							"logoAnnotations": [AnyObject](),
							"textAnnotations": [AnyObject](),
							"safeSearchAnnotation": [
								"adult": "UNKNOWN",
								"spoof": "UNKNOWN",
								"medical": "UNKNOWN",
								"violence": "UNKNOWN",
							],
							"imagePropertiesAnnotation": [
								"dominantColors": [
									"colors": [
										[
											"color": [
												"red": 0,
												"green": 255,
												"blue": 0,
												"alpha": 1,
											],
											"score": 0.75,
											"pixelFraction": 0.25,
										],
									]
								]
							],
						],
						expected: AnnotationResponse(
							faceAnnotations: [],
							labelAnnotations: [],
							landmarkAnnotations: [],
							logoAnnotations: [],
							textAnnotations: [],
							safeSearchAnnotation: SafeSearchAnnotation(
								adultContentLikelihood: .Unknown,
								spoofContentLikelihood: .Unknown,
								medicalContentLikelihood: .Unknown,
								violentContentLikelihood: .Unknown
							),
							imagePropertiesAnnotation: ImagePropertiesAnnotation(dominantColors: [
								try! ColorInformation(
									color: try! Color(red: 0, green: 1, blue: 0, alpha: 1),
									score: 0.75,
									pixelFraction: 0.25
								),
							])
						)
					)
				}

				context("with empty dictionary") {
					initWithAPIRepresentationShouldSucceed(
						value: [String: AnyObject](),
						expected: AnnotationResponse(
							faceAnnotations: nil,
							labelAnnotations: nil,
							landmarkAnnotations: nil,
							logoAnnotations: nil,
							textAnnotations: nil,
							safeSearchAnnotation: nil,
							imagePropertiesAnnotation: nil
						)
					)
				}

				context("with invalid representation value type") {
					initWithAPIRepresentationShouldFail(
						value: "foobar",
						type: AnnotationResponse.self,
						error: APIRepresentationError.UnexpectedValueType
					)
				}

			}
			
		}

	}

}
