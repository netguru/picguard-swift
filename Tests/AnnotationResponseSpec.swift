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

				context("with valid dictionary") {

					context("with label annotations") {
						initWithAPIRepresentationShouldSucceed(
							value:[
								"labelAnnotations": [
									[
										"mid": "/m/068hy",
										"description": "dog",
										"score": 0.2
									],
									[
										"mid": "/m/032hy",
										"description": "owl",
										"score": 0.89
									]
								]
							],
							expected: AnnotationResponse(labelAnnotations: [
									try! LabelAnnotation(entityIdentifier: "/m/068hy", description: "dog", score: 0.2),
									try! LabelAnnotation(entityIdentifier: "/m/032hy", description: "owl", score: 0.89)
								]
							)
						)
					}
				}

				describe("init with api representation") {

					context("with empty dictionary") {
						initWithAPIRepresentationShouldFail(
							value: [String: AnyObject](),
							type: AnnotationResponse.self,
							error: APIRepresentationError.MissingDictionaryKey
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
}
