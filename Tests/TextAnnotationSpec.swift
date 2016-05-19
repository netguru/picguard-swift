//
// TextAnnotationSpec.swift
//
// Copyright (c) 2016 Netguru Sp. z o.o. All rights reserved.
// Licensed under the MIT License.
//

import Nimble
import Quick
import Picguard

final class TextAnnotationSpec: QuickSpec {

	override func spec() {

		describe("TextAnnotation") {

			describe("init with api representation") {

				context("with valid dictionary") {

					context("with locale") {
						initWithAPIRepresentationShouldSucceed(
							value: ["description": "foo", "locale": "bar", "boundingPoly": ["vertices": [["x": 1, "y": 2]]]],
							expected: TextAnnotation(boundingPolygon: BoundingPolygon(vertices: [Vertex(x: 1, y: 2)]), description: "foo", locale: "bar")
						)
					}

					context("without locale") {
						initWithAPIRepresentationShouldSucceed(
							value: ["description": "baz", "boundingPoly": ["vertices": [["x": 3, "y": 4]]]],
							expected: TextAnnotation(boundingPolygon: BoundingPolygon(vertices: [Vertex(x: 3, y: 4)]), description: "baz", locale: nil)
						)
					}

				}

				context("with empty dictionary") {
					initWithAPIRepresentationShouldFail(
						value: [String: AnyObject](),
						type: TextAnnotation.self,
						error: APIRepresentationError.MissingDictionaryKey
					)
				}

				context("with invalid representation value type") {
					initWithAPIRepresentationShouldFail(
						value: "foobar",
						type: TextAnnotation.self,
						error: APIRepresentationError.UnexpectedValueType
					)
				}

			}
			
		}
		
	}
	
}
