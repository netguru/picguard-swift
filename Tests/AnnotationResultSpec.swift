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
					it("should succeed to initialize") {
						expect {
							PicguardResult<AnnotationResponse>(APIRepresentationValue: try APIRepresentationValue(value: [
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
				}

				context("with successful dictionary") {
					it("should succeed to initialize") {
						expect {
							PicguardResult<AnnotationResponse>(APIRepresentationValue: try APIRepresentationValue(value: [String: AnyObject]()))
						}.to(NonNilMatcherFunc { expression, _ in
							if let actual = try expression.evaluate() {
								if case .Value(let response) = actual {
									return response == AnnotationResponse(
										faceAnnotations: nil,
										labelAnnotations: nil,
										landmarkAnnotations: nil,
										logoAnnotations: nil,
										textAnnotations: nil,
										safeSearchAnnotation: nil,
										imagePropertiesAnnotation: nil
									)
								}
							}
							return false
						})
					}
				}

				context("with invalid representation value type") {
					it("should succeed to initialize") {
						expect {
							PicguardResult<AnnotationResponse>(APIRepresentationValue: try APIRepresentationValue(value: "foobar"))
						}.to(NonNilMatcherFunc { expression, _ in
							if let actual = try expression.evaluate() {
								if case .Error(let error as APIRepresentationError) = actual {
									if case .UnexpectedValueType = error {
										return true
									}
								}
							}
							return false
						})
					}
				}
				
			}
			
		}
		
	}
	
}
