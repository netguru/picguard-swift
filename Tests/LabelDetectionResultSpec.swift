//
// LabelDetectionResultSpec.swift
//
// Copyright (c) 2016 Netguru Sp. z o.o. All rights reserved.
// Licensed under the MIT License.
//

import Nimble
import Quick
import Picguard

final class LabelDetectionResultSpec: QuickSpec {

	override func spec() {

		describe("LabelDetectionResult") {

			context("during initialization with raw values") {

				let initialize: (score: Double) throws -> LabelDetectionResult = { score in
					try LabelDetectionResult(entityIdentifier: "", description: "", score: score)
				}

				it("should throw when trying to pass a score less than zero") {
					expect {
						try initialize(score: -0.25)
					}.to(throwError(LabelDetectionResult.Error.InvalidScore))
				}

				it("should throw when trying to pass a score greater than one") {
					expect {
						try initialize(score: 1.1)
					}.to(throwError(LabelDetectionResult.Error.InvalidScore))
				}

				it("should succeed when trying to pass a correct score") {
					expect {
						try initialize(score: 0.666666)
					}.toNot(throwError())
				}

				it("should succeed when trying to pass a minimal score") {
					expect {
						try initialize(score: 0.0)
					}.toNot(throwError())
				}

				it("should succeed when trying to pass a maximal score") {
					expect {
						try initialize(score: 1.0)
					}.toNot(throwError())
				}

			}

			context("during intialization with json representation") {

				let initialize: (json: [String: Any]) throws -> LabelDetectionResult = { json in
					try LabelDetectionResult(JSONRepresentation: json)
				}

				it("should throw when passing an empty json") {
					expect {
						try initialize(json: [:])
					}.to(throwError(LabelDetectionResult.Error.InvalidJSONRepresentation))
				}

				it("should throw when passing an invalid json") {
					expect {
						try initialize(json: [
							"mid": true,
							"description": "foo",
							"score": 0.5,
						])
					}.to(throwError(LabelDetectionResult.Error.InvalidJSONRepresentation))
				}

				it("should throw when passing a valid json with invalid score") {
					expect {
						try initialize(json: [
							"mid": "foo",
							"description": "bar",
							"score": 2.0,
						])
					}.to(throwError(LabelDetectionResult.Error.InvalidScore))
				}

				it("should succeed when passing a valid json") {
					expect {
						try initialize(json: [
							"mid": "foo",
							"description": "bar",
							"score": 0.123456789,
						])
					}.toNot(throwError())
				}

			}

			context("after being initialized with raw values") {

				let entityIdentifier = "foo"
				let description = "bar"
				let score = 0.987654321

				var sut: LabelDetectionResult! = nil

				beforeEach {
					sut = try! LabelDetectionResult(entityIdentifier: entityIdentifier, description: description, score: score)
				}

				it("should contain correct fields") {
					expect(sut.entityIdentifier).to(equal(entityIdentifier))
					expect(sut.description).to(equal(description))
					expect(sut.score).to(equal(score))
				}

			}

			context("after being initialized with json representation") {

				let entityIdentifier = "foo"
				let description = "bar"
				let score = 0.987654321

				let json: [String: Any] = [
					"mid": entityIdentifier,
					"description": description,
					"score": score
				]

				var sut: LabelDetectionResult! = nil

				beforeEach {
					sut = try! LabelDetectionResult(JSONRepresentation: json)
				}

				it("should contain correct fields") {
					expect(sut.entityIdentifier).to(equal(entityIdentifier))
					expect(sut.description).to(equal(description))
					expect(sut.score).to(equal(score))
				}

			}

		}

	}

}
