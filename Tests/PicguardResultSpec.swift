//
// PicguardResultSpec.swift
//
// Copyright (c) 2016 Netguru Sp. z o.o. All rights reserved.
// Licensed under the MIT License.
//

import Nimble
import Quick
import Picguard

final class PicguardResultSpec: QuickSpec {

	override func spec() {

		describe("PicguardResult") {

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
						}.to(beSuccessful(AnnotationResponse(
							faceAnnotations: nil,
							labelAnnotations: nil,
							landmarkAnnotations: nil,
							logoAnnotations: nil,
							textAnnotations: nil,
							safeSearchAnnotation: nil,
							imagePropertiesAnnotation: nil
						)))
					}
				}

				context("with invalid representation value type") {
					it("should succeed to initialize") {
						expect {
							PicguardResult<AnnotationResponse>(APIRepresentationValue: try APIRepresentationValue(value: "foobar"))
						}.to(beErroneus(APIRepresentationError.UnexpectedValueType))
					}
				}
				
			}

			describe("map") {

				context("when subject is successful") {

					let subject = PicguardResult<Int>.Success(3)

					it("should apply map transform") {
						expect { _ -> PicguardResult<String> in
							subject.map { _ in "foo" }
						}.to(beSuccessful("foo"))
					}

				}

				context("when subject is erroneus") {

					enum MockError: ErrorType { case Boom }

					let subject = PicguardResult<Int>.Error(MockError.Boom)

					it("should not apply map transform") {
						expect { _ -> PicguardResult<String> in
							subject.map { _ in "foo" }
						}.to(beErroneus(MockError.Boom))
					}

				}

			}
			
		}
		
	}
	
}
