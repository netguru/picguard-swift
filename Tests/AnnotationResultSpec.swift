//
// AnnotationResultSpec.swift
//
// Copyright (c) 2016 Netguru Sp. z o.o. All rights reserved.
// Licensed under the MIT License.
//

import Nimble
import Quick
import Picguard

final class AnnotationResultSpec: QuickSpec {

	override func spec() {

		describe("AnnotationResult") {

			describe("init with api representation") {

				context("with erroneous dictionary") {
					expect {
						AnnotationResult(APIRepresentationValue: try APIRepresentationValue(value: [
							"status": [
								"code": 1,
								"message": "foobar",
							]
						]))
					}.to(NonNilMatcherFunc { expression, _ in
						if let actual = try expression.evaluate() {
							if case .Error(let error as AnnotationError) = actual {
								return error.code == 1 && error.message == "foobar"
							}
						}
						return false
					})
				}

				context("with successful dictionary") {
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
