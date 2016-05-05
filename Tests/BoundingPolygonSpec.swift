//
// BoundingPolygonSpec.swift
//
// Copyright (c) 2016 Netguru Sp. z o.o. All rights reserved.
// Licensed under the MIT License.
//

import Nimble
import Quick
import Picguard

final class BoundingPolygonSpec: QuickSpec {

	override func spec() {

		describe("BoundingPolygon") {

			describe("init with api representation") {

				context("with valid dictionary") {
					initWithAPIRepresentationShouldSucceed(
						value: ["vertices": [["x": 1, "y": 2], ["x": 3, "y": 4]]],
						expected: BoundingPolygon(vertices: [Vertex(x: 1, y: 2), Vertex(x: 3, y: 4)])
					)
				}

				context("with empty dictionary") {
					initWithAPIRepresentationShouldFail(
						value: [String: [String: Int]](),
						type: BoundingPolygon.self,
						error: APIRepresentationError.MissingDictionaryKey
					)
				}

				context("with invalid representation value type") {
					initWithAPIRepresentationShouldFail(
						value: "foobar",
						type: BoundingPolygon.self,
						error: APIRepresentationError.UnexpectedValueType
					)
				}

			}

		}

	}

}
