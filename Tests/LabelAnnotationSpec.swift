//
// LabelAnnotationSpec.swift
//
// Copyright (c) 2016 Netguru Sp. z o.o. All rights reserved.
// Licensed under the MIT License.
//

import Nimble
import Quick
import Picguard

final class LabelAnnotationSpec: QuickSpec {

	override func spec() {

		describe("LabelAnnotation") {

			func initWithScoreShouldSucceed(score score: Double) {
				it("should succeed to initialize") {
					expect {
						try LabelAnnotation(entityIdentifier: "foo", description: "bar", score: score)
					}.toNot(throwError())
				}
			}

			func initWithScoreShouldFail(score score: Double) {
				it("should fail to initialize") {
					expect {
						try LabelAnnotation(entityIdentifier: "foo", description: "bar", score: score)
					}.to(throwError(LabelAnnotation.Error.InvalidScore))
				}
			}

			describe("init with score") {

				context("with correct medium score") {
					initWithScoreShouldSucceed(score: 0.6969)
				}

				context("with minimal score") {
					initWithScoreShouldSucceed(score: 0)
				}

				context("with maximal score") {
					initWithScoreShouldSucceed(score: 1)
				}

				context("with less than zero score") {
					initWithScoreShouldFail(score: -0.25)
				}

				context("with greater than one score") {
					initWithScoreShouldFail(score: 1.2)
				}

			}

			describe("init with api representation") {

				context("with valid dictionary") {
					initWithAPIRepresentationShouldSucceed(value: [
						"mid": "foo",
						"description": "bar",
						"score": 0.123456789,
					], expected: try! LabelAnnotation(
						entityIdentifier: "foo",
						description: "bar",
						score: 0.123456789
					))
				}

				context("with empty dictionary") {
					initWithAPIRepresentationShouldFail(value: [:], type: LabelAnnotation.self, error: APIRepresentationError.MissingDictionaryKey)
				}

				context("with dictionawy with invalid types") {
					initWithAPIRepresentationShouldFail(value: [
						"mid": 123,
						"description": 123,
						"score": true,
					], type: LabelAnnotation.self, error: APIRepresentationError.UnexpectedValueType)
				}

				context("with dictionary with invalid score") {
					initWithAPIRepresentationShouldFail(value: [
						"mid": "foo",
						"description": "bar",
						"score": 2.345678,
					], type: LabelAnnotation.self, error: LabelAnnotation.Error.InvalidScore)
				}

			}

		}

	}

}

// MARK: -

extension LabelAnnotation: Equatable {}

public func == (lhs: LabelAnnotation, rhs: LabelAnnotation) -> Bool {
	return (
		lhs.entityIdentifier == rhs.entityIdentifier &&
		lhs.description == rhs.description &&
		lhs.score == rhs.score
	)
}
