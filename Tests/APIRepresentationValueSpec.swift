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

			func initWithValueShoudSucceed(value value: AnyObject, expected: APIRepresentationValue) {
				it("should succeed to initialize") {
					expect {
						try APIRepresentationValue(value: value)
					}.to(equal(expected))
				}
			}

			func initWithValueShouldFail(value value: AnyObject) {
				it("should fail to intialize") {
					expect {
						try APIRepresentationValue(value: value)
					}.to(throwError(APIRepresentationError.UnsupportedInitType))
				}
			}

			func initWithDataShouldSucceed(data data: NSData, expected: APIRepresentationValue) {
				it("should succeed to initialize") {
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

			func serializeAPIRepresentation(object: AnyObject) -> NSData {
				return try! NSJSONSerialization.dataWithJSONObject(object, options: [])
			}

			func getFlatShouldSucceed(subject subject: APIRepresentationValue, key: String, expected: APIRepresentationValue) {
				it("should succeed to get value") {
					expect { _ -> APIRepresentationValue in
						try subject.get(key)
					}.to(equal(expected))
				}
			}

			func getFlatShouldFail(subject subject: APIRepresentationValue, key: String, expectedError: APIRepresentationError) {
				it("should fail to get value") {
					expect { _ -> APIRepresentationValue in
						try subject.get(key)
					}.to(throwError(expectedError))
				}
			}

			func getNonOptionalElementShouldSucceed<T: protocol<Equatable, APIRepresentationConvertible>>(subject subject: APIRepresentationValue, key: String, expected: T) {
				it("should succeed to get value") {
					expect { _ -> T in
						try subject.get(key)
					}.to(equal(expected))
				}
			}

			func getNonOptionalElementShouldFail<T: APIRepresentationConvertible>(subject subject: APIRepresentationValue, key: String, type: T.Type, expectedError: APIRepresentationError) {
				it("should fail to get value") {
					expect { _ -> T in
						try subject.get(key)
					}.to(throwError(expectedError))
				}
			}

			func getOptionalElementShouldSucceed<T: protocol<Equatable, APIRepresentationConvertible>>(subject subject: APIRepresentationValue, key: String, expected: T?) {
				it("should succeed to get value") {
					if let expected = expected {
						expect { _ -> T? in
							try subject.get(key)
						}.to(equal(expected))
					} else {
						expect { _ -> T? in
							try subject.get(key)
						}.to(beNil())
					}
				}
			}

			func getOptionalElementShouldFail<T: APIRepresentationConvertible>(subject subject: APIRepresentationValue, key: String, type: T.Type, expectedError: APIRepresentationError) {
				it("should fail to get value") {
					expect { _ -> T? in
						try subject.get(key)
					}.to(throwError(expectedError))
				}
			}

			func getArrayShouldSucceed<T: protocol<Equatable, APIRepresentationConvertible>>(subject subject: APIRepresentationValue, key: String, expected: [T]) {
				it("should succeed to get value") {
					expect { _ -> [T] in
						try subject.get(key)
					}.to(equal(expected))
				}
			}

			func getArrayShouldFail<T: APIRepresentationConvertible>(subject subject: APIRepresentationValue, key: String, type: T.Type, expectedError: APIRepresentationError) {
				it("should fail to get value") {
					expect { _ -> [T] in
						try subject.get(key)
					}.to(throwError(expectedError))
				}
			}

			func getDictionaryShouldSucceed<T: protocol<Equatable, APIRepresentationConvertible>>(subject subject: APIRepresentationValue, key: String, expected: [String: T]) {
				it("should succeed to get value") {
					expect { _ -> [String: T] in
						try subject.get(key)
					}.to(equal(expected))
				}
			}

			func getDictionaryShouldFail<T: APIRepresentationConvertible>(subject subject: APIRepresentationValue, key: String, type: T.Type, expectedError: APIRepresentationError) {
				it("should fail to get value") {
					expect { _ -> [String: T] in
						try subject.get(key)
					}.to(throwError(expectedError))
				}
			}

			// MARK: -

			describe("init with value") {

				context("with NSNull value") {
					initWithValueShoudSucceed(value: NSNull(), expected: .Null)
				}

				context("with boolean NSNumber value") {
					initWithValueShoudSucceed(value: NSNumber(bool: true), expected: .Bool(true))
				}

				context("with numeric NSNumber value") {
					initWithValueShoudSucceed(value: NSNumber(long: 123), expected: .Number(123))
				}

				context("with Int value") {
					initWithValueShoudSucceed(value: 4, expected: .Number(4))
				}

				context("with Double value") {
					initWithValueShoudSucceed(value: 5.6, expected: .Number(5.6))
				}

				context("with Bool value") {
					initWithValueShoudSucceed(value: false, expected: .Bool(false))
				}

				context("with String value") {
					initWithValueShoudSucceed(value: "foobar", expected: .String("foobar"))
				}

				context("with Array value") {
					initWithValueShoudSucceed(value: [
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
					initWithValueShoudSucceed(value: [
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
					initWithValueShouldFail(value: Set<String>())
				}

			}

			describe("init with data") {

				context("with dictionary of primitives") {
					initWithDataShouldSucceed(data: serializeAPIRepresentation([
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
					initWithDataShouldSucceed(data: serializeAPIRepresentation([
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
					initWithDataShouldSucceed(data: serializeAPIRepresentation([
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
					initWithDataShouldSucceed(data: serializeAPIRepresentation([
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

			describe("get flat value") {

				let subject = try! APIRepresentationValue(value: ["first": 123, "second": ["third": "foo"], "null": NSNull()])

				context("when they key exists") {
					getFlatShouldSucceed(subject: subject, key: "first", expected: .Number(123))
				}

				context("when the key does not exist") {
					getFlatShouldFail(subject: subject, key: "fourth", expectedError: .MissingDictionaryKey)
				}

				context("when the subject has incorrect type") {
					getFlatShouldFail(subject: .String("foo"), key: "bar", expectedError: .UnexpectedValueType)
				}

				it("should be composable") {
					expect { _ -> APIRepresentationValue in
						try subject.get("second").get("third")
					}.to(equal(APIRepresentationValue.String("foo")))
				}

			}

			describe("get non optional value") {

				let subject = try! APIRepresentationValue(value: ["first": 123, "second": "foo", "null": NSNull()])

				context("when the key exists and has correct value") {
					getNonOptionalElementShouldSucceed(subject: subject, key: "first", expected: 123)
				}

				context("when the key does not exist") {
					getNonOptionalElementShouldFail(subject: subject, key: "third", type: String.self, expectedError: .MissingDictionaryKey)
				}

				context("when the key has invalid type") {
					getNonOptionalElementShouldFail(subject: subject, key: "first", type: String.self, expectedError: .UnexpectedValueType)
				}

				context("when the subject has icorrect type") {
					getNonOptionalElementShouldFail(subject: .String("foo"), key: "bar", type: String.self, expectedError: .UnexpectedValueType)
				}

			}

			describe("get optional value") {

				let subject = try! APIRepresentationValue(value: ["first": 123, "second": "baz", "null": NSNull()])

				context("when the key exists and has correct value") {
					getOptionalElementShouldSucceed(subject: subject, key: "first", expected: 123)
				}

				context("when the key does not exist") {
					getOptionalElementShouldSucceed(subject: subject, key: "third", expected: Optional<String>.None)
				}

				context("when the key exists and is null") {
					getOptionalElementShouldSucceed(subject: subject, key: "null", expected: Optional<String>.None)
				}

				context("when the key has invalid type") {
					getOptionalElementShouldFail(subject: subject, key: "first", type: String.self, expectedError: .UnexpectedValueType)
				}

				context("when the subject has icorrect type") {
					getOptionalElementShouldFail(subject: .String("foo"), key: "bar", type: String.self, expectedError: .UnexpectedValueType)
				}

			}

			describe("get array") {

				let subject = try! APIRepresentationValue(value: ["first": ["foo", "bar"], "second": ["baz", 123], "null": NSNull()])

				context("when the key exists and holds values of the same type") {
					getArrayShouldSucceed(subject: subject, key: "first", expected: ["foo", "bar"])
				}

				pending("when the key exists and holds values of different types") {
					// not yet supported by the compiler
					// getArrayShouldSucceed(subject: subject, key: "second", expected: ["baz", 123] as [APIRepresentationConvertible])
				}

				context("when the key does not exist") {
					getArrayShouldFail(subject: subject, key: "third", type: String.self, expectedError: .MissingDictionaryKey)
				}

				context("when the key has invalid type") {
					getArrayShouldFail(subject: subject, key: "null", type: String.self, expectedError: .UnexpectedValueType)
				}

				context("when the subject has icorrect type") {
					getArrayShouldFail(subject: .String("foo"), key: "bar", type: String.self, expectedError: .UnexpectedValueType)
				}

			}

			describe("get dictionary") {

				let subject = try! APIRepresentationValue(value: ["first": ["foo": 123, "bar": 456], "second": ["foo": 123, "bar": "baz"], "null": NSNull()])

				context("when the key exists and holds values of the same type") {
					getDictionaryShouldSucceed(subject: subject, key: "first", expected: ["foo": 123, "bar": 456])
				}

				pending("when the key exists and holds values of different types") {
					 // not yet supported by the compiler
					 // getDictionaryShouldSucceed(subject: subject, key: "second", expected: ["foo": 123, "bar": "baz"] as [String: APIRepresentationConvertible])
				}

				context("when the key does not exist") {
					getDictionaryShouldFail(subject: subject, key: "third", type: String.self, expectedError: .MissingDictionaryKey)
				}

				context("when the key has invalid type") {
					getDictionaryShouldFail(subject: subject, key: "null", type: String.self, expectedError: .UnexpectedValueType)
				}

				context("when the subject has icorrect type") {
					getDictionaryShouldFail(subject: .String("foo"), key: "bar", type: String.self, expectedError: .UnexpectedValueType)
				}

			}

		}

	}

}
