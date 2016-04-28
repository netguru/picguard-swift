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

		describe("LabelDetectionResult") {

			func initWithScoreShouldSucceed(score score: Double) {
				it("should succeed to initialize") {
					expect {
						try LabelAnnotation(entityIdentifier: "foo", description: "bar", score: score)
					}.to(NonNilMatcherFunc { expression, _ in
						guard let actual = try expression.evaluate() else {
							return false
						}
						return actual.score == score
					})
				}
			}

			func initWithScoreShouldFail(score score: Double) {
				it("should fail to initialize") {
					expect {
						try LabelAnnotation(entityIdentifier: "foo", description: "bar", score: score)
					}.to(throwError(LabelAnnotation.Error.InvalidScore))
				}
			}

			func initWithAPIRepresentationShouldSucceed(dictionary dictionary: [String: AnyObject], expected: LabelAnnotation) {
				it("should succeed to initialize") {
					expect {
						try LabelAnnotation(APIRepresentationValue: APIRepresentationValue(data: NSJSONSerialization.dataWithJSONObject(dictionary, options: [])))
					}.to(NonNilMatcherFunc<LabelAnnotation> { expression, _ in
						guard let actual = try expression.evaluate() else {
							return false
						}
						return (
							actual.entityIdentifier == expected.entityIdentifier &&
							actual.description == expected.description &&
							actual.score == expected.score
						)
					})
				}
			}

			func initWithAPIRepresentationShouldFail<E: ErrorType>(dictionary dictionary: [String: AnyObject], error: E) {
				it("should fail to initialize") {
					expect {
						try LabelAnnotation(APIRepresentationValue: APIRepresentationValue(data: NSJSONSerialization.dataWithJSONObject(dictionary, options: [])))
					}.to(throwError(error))
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
					initWithAPIRepresentationShouldSucceed(dictionary: [
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
					initWithAPIRepresentationShouldFail(dictionary: [:], error: APIRepresentationError.MissingDictionaryKey)
				}

				context("with dictionawy with invalid types") {
					initWithAPIRepresentationShouldFail(dictionary: [
						"mid": 123,
						"description": 123,
						"score": true,
					], error: APIRepresentationError.UnexpectedValueType)
				}

				context("with dictionary with invalid score") {
					initWithAPIRepresentationShouldFail(dictionary: [
						"mid": "foo",
						"description": "bar",
						"score": 2.345678,
					], error: LabelAnnotation.Error.InvalidScore)
				}

			}

		}

	}

}
