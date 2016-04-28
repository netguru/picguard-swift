//
// Base64ImageEncoderSpec.swift
//
// Copyright (c) 2016 Netguru Sp. z o.o. All rights reserved.
// Licensed under the MIT License.
//

import Foundation

import Nimble
import Quick
import Picguard

final class AnnotationRequestSpec: QuickSpec {

	override func spec() {

		describe("AnnotationRequest") {

			var sut: AnnotationRequest!

			context("when initialized with Label feature") {

				var featuresJSON: [[String: AnyObject]]!

				beforeEach {
					let features = Set([AnnotationRequest.Feature.Label(maxResults: 1)])
					let image = AnnotationRequest.Image.Image(UIImage())
					sut = try! AnnotationRequest.init(features: features, image: image)
					let JSON = try! sut.JSONDictionaryRepresentation(MockImageEncoder())
					featuresJSON = JSON["features"] as! [[String: AnyObject]]
				}

				it("should have 1 feature") {
					expect(featuresJSON.count).to(equal(1))
				}

				describe("first feature") {

					var firstFeatureJSON: [String: AnyObject]!

					beforeEach {
						firstFeatureJSON = featuresJSON.first
					}

					it("should be Label type") {
						expect(firstFeatureJSON["type"] as? String).to(equal("LABEL_DETECTION"))
					}

					it("should have max results 1") {
						expect(firstFeatureJSON["maxResults"] as? Int).to(equal(1))
					}
				}
			}

			context("when initialized with empty features set") {

				it("should thorw EmptyFeaturesSet error") {
					expect {
						try AnnotationRequest.init(features: Set(), image: .URL("fixture url"))
					}.to(throwError(AnnotationRequest.Error.EmptyFeaturesSet))
				}
			}
		}
	}
}
