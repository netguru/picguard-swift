//
// FaceLandmarkSpec.swift
//
// Copyright (c) 2016 Netguru Sp. z o.o. All rights reserved.
// Licensed under the MIT License.
//

import Nimble
import Quick
import Picguard

final class FaceLandmarkSpec: QuickSpec {

	override func spec() {

		describe("FaceLandmark") {

			describe("init with api representation") {

				context("with valid dictionary") {
					initWithAPIRepresentationShouldSucceed(
						value: ["type": "UNKNOWN_LANDMARK", "position": ["x": 1, "y": 2, "z": 3]],
						expected: FaceLandmark(type: .Unknown, position: Position(x: 1, y: 2, z: 3))
					)
				}

				context("with empty dictionary") {
					initWithAPIRepresentationShouldFail(
						value: [String: AnyObject](),
						type: FaceLandmark.self,
						error: APIRepresentationError.MissingDictionaryKey
					)
				}

				context("with invalid representation value type") {
					initWithAPIRepresentationShouldFail(
						value: "foobar",
						type: FaceLandmark.self,
						error: APIRepresentationError.UnexpectedValueType
					)
				}
				
			}
			
		}
		
	}
	
}
