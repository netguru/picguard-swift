//
// APIRepresentationValueSpec.swift
//
// Copyright (c) 2016 Netguru Sp. z o.o. All rights reserved.
// Licensed under the MIT License.
//

import Nimble
import Quick
import Picguard

final class APIRepresentationValueSpec: QuickSpec {

	override func spec() {

		describe("APIRepresentationValue") {

			describe("init with value") {

				func itShouldSuccessfullyInitialize(value value: AnyObject, expected: APIRepresentationValue) {
					it("should successfully initialize") {
						expect {
							try APIRepresentationValue(value: value)
						}.to(equal(expected))
					}
				}

				func itShouldFailToInitialize(value value: AnyObject) {
					it("should fail to intialize") {
						expect {
							try APIRepresentationValue(value: value)
						}.to(throwError(APIRepresentationError.UnsupportedInitType))
					}
				}

				context("with NSNull value") {
					itShouldSuccessfullyInitialize(value: NSNull(), expected: .Null)
				}

				context("with boolean NSNumber value") {
					itShouldSuccessfullyInitialize(value: NSNumber(bool: true), expected: .Bool(true))
				}

				context("with numeric NSNumber value") {
					itShouldSuccessfullyInitialize(value: NSNumber(long: 123), expected: .Number(123))
				}

				context("with Int value") {
					itShouldSuccessfullyInitialize(value: 4, expected: .Number(4))
				}

				context("with Double value") {
					itShouldSuccessfullyInitialize(value: 5.6, expected: .Number(5.6))
				}

				context("with Bool value") {
					itShouldSuccessfullyInitialize(value: false, expected: .Bool(false))
				}

				context("with String value") {
					itShouldSuccessfullyInitialize(value: "foobar", expected: .String("foobar"))
				}

				context("with Array value") {
					itShouldSuccessfullyInitialize(value: [
						true,
						2,
						"baz"
					] as [AnyObject], expected: .Array([
						.Bool(true),
						.Number(2),
						.String("baz"),
					]))
				}

				context("with Dictionary value") {
					itShouldSuccessfullyInitialize(value: [
						"foo": false,
						"bar": 3,
						"baz": "qux",
					] as [String: AnyObject], expected: .Dictionary([
						"foo": .Bool(false),
						"bar": .Number(3),
						"baz": .String("qux"),
					]))
				}

				context("with an invalid value") {
					itShouldFailToInitialize(value: Set<String>())
				}

			}

			describe("init with data") {

				func itShouldSuccessfullyInitialize(data data: NSData, expected: APIRepresentationValue) {
					it("should successfully initialize") {
						expect {
							try APIRepresentationValue(data: data)
						}.to(equal(expected))
					}
				}

				func itShouldFailToInitialize(data data: NSData) {
					it("should fail to intialize") {
						expect {
							try APIRepresentationValue(data: data)
						}.to(throwError(APIRepresentationError.UnsupportedInitType))
					}
				}

				func serializeJSON(object object: AnyObject) -> NSData {
					return try! NSJSONSerialization.dataWithJSONObject(object, options: [])
				}

				context("with dictionary of primitives") {
					itShouldSuccessfullyInitialize(data: serializeJSON(object: [
						"null": NSNull(),
						"int": 4,
						"double": 2.1,
						"bool": true,
						"string": "foobar",
					]), expected: .Dictionary([
						"null": .Null,
						"int": .Number(4),
						"double": .Number(2.1),
						"bool": .Bool(true),
						"string": .String("foobar"),
					]))
				}

				context("with array of primitives") {
					itShouldSuccessfullyInitialize(data: serializeJSON(object: [
						NSNull(),
						21,
						3.7,
						false,
						"bazqux",
					]), expected: .Array([
						.Null,
						.Number(21),
						.Number(3.7),
						.Bool(false),
						.String("bazqux"),
					]))
				}

				context("with recursive dictionary") {
					itShouldSuccessfullyInitialize(data: serializeJSON(object: [
						"first": [
							"second": [
								"third": [
									"foo": "bar",
								],
							],
						],
					]), expected: .Dictionary([
						"first": .Dictionary([
							"second": .Dictionary([
								"third": .Dictionary([
									"foo": .String("bar"),
								]),
							]),
						]),
					]))
				}

				context("with recursive array") {
					itShouldSuccessfullyInitialize(data: serializeJSON(object: [
						"foo",
						[
							"bar",
							[
								"baz",
							],
						],
					]), expected: .Array([
						.String("foo"),
						.Array([
							.String("bar"),
							.Array([
								.String("baz"),
							]),
						]),
					]))
				}

			}

		}

	}

}
