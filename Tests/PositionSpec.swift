//
// PositionSpec.swift
//
// Copyright (c) 2016 Netguru Sp. z o.o. All rights reserved.
// Licensed under the MIT License.
//

import Nimble
import Quick
import Picguard

final class PositionSpec: QuickSpec {

	override func spec() {

		describe("Position") {

			describe("init with api representation") {

				context("with valid dictionary") {
					initWithAPIRepresentationShouldSucceed(
						value: ["x": 1, "y": 2, "z": 3],
						expected: Position(x: 1, y: 2, z: 3)
					)
				}

				context("with empty dictionary") {
					initWithAPIRepresentationShouldFail(
						value: [String: Int](),
						type: Position.self,
						error: APIRepresentationError.MissingDictionaryKey
					)
				}

				context("with invalid representation value type") {
					initWithAPIRepresentationShouldFail(
						value: "foobar",
						type: Position.self,
						error: APIRepresentationError.UnexpectedValueType
					)
				}

			}

		}

	}

}
