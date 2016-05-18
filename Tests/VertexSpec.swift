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

					context("when there are x and y coordinates") {
						initWithAPIRepresentationShouldSucceed(
							value: ["x": 1, "y": 2],
							expected: Vertex(x: 1, y: 2)
						)
					}

					context("when there is only x coordinate") {
						initWithAPIRepresentationShouldSucceed(
							value: ["x": 1],
							expected: Vertex(x: 1, y: nil)
						)
					}

					context("when there is only y coordinate") {
						initWithAPIRepresentationShouldSucceed(
							value: ["y": 2],
							expected: Vertex(x: nil, y: 2)
						)
					}

					context("when dictionary is empty") {
						initWithAPIRepresentationShouldSucceed(
							value: [:],
							expected: Vertex(x: nil, y: nil)
						)
					}

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
