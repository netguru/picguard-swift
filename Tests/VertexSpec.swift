//
// VertexSpec.swift
//
// Copyright (c) 2016 Netguru Sp. z o.o. All rights reserved.
// Licensed under the MIT License.
//

import Nimble
import Quick
import Picguard

final class VertexSpec: QuickSpec {

	override func spec() {

		describe("Vertex") {

			describe("init with api representation") {

				context("with valid dictionary") {
					initWithAPIRepresentationShouldSucceed(
						value: ["x": 1, "y": 2],
						expected: Vertex(x: 1, y: 2)
					)
				}

				context("with empty dictionary") {
					initWithAPIRepresentationShouldFail(
						value: [String: Int](),
						type: Vertex.self,
						error: APIRepresentationError.MissingDictionaryKey
					)
				}

				context("with invalid representation value type") {
					initWithAPIRepresentationShouldFail(
						value: "foobar",
						type: Vertex.self,
						error: APIRepresentationError.UnexpectedValueType
					)
				}

			}

		}

	}

}
