//
// APIRepresentationConvertibleSpec.swift
//
// Copyright (c) 2016 Netguru Sp. z o.o. All rights reserved.
// Licensed under the MIT License.
//

import Nimble
import Quick
import Picguard

final class APIRepresentationConvertibleSpec: QuickSpec {

	override func spec() {

		func initShouldSucceed<T: protocol<Equatable, APIRepresentationConvertible>>(value value: AnyObject, expected: T) {
			it("should successfully initialize") {
				expect {
					try T(APIRepresentationValue: APIRepresentationValue(value: value))
				}.to(equal(expected))
			}
		}

		func initShouldFail<T: APIRepresentationConvertible>(value value: AnyObject, type: T.Type) {
			it("should fail to initalize") {
				expect {
					try T(APIRepresentationValue: APIRepresentationValue(value: value))
				}.to(throwError(APIRepresentationError.UnexpectedValueType))
			}
		}

		describe("Int") {

			context("when initialized with integer API representation") {
				initShouldSucceed(value: 1, expected: 1)
			}

			context("when initialized with double API representation") {
				initShouldSucceed(value: 2.3, expected: Int(2.3))
			}

			context("when initialized with null API representation") {
				initShouldFail(value: NSNull(), type: Int.self)
			}

			context("when initialized with bool API representation") {
				initShouldFail(value: true, type: Int.self)
			}

			context("when initialized with string API representation") {
				initShouldFail(value: "foo", type: Int.self)
			}

			context("when initialized with array API representation") {
				initShouldFail(value: [AnyObject](), type: Int.self)
			}

			context("when initialized with dictionary API representation") {
				initShouldFail(value: [String: AnyObject](), type: Int.self)
			}

		}

		describe("Double") {

			context("when initialized with integer API representation") {
				initShouldSucceed(value: 1.2, expected: 1.2)
			}

			context("when initialized with double API representation") {
				initShouldSucceed(value: 3, expected: Double(3))
			}

			context("when initialized with null API representation") {
				initShouldFail(value: NSNull(), type: Double.self)
			}

			context("when initialized with bool API representation") {
				initShouldFail(value: true, type: Double.self)
			}

			context("when initialized with string API representation") {
				initShouldFail(value: "foo", type: Double.self)
			}

			context("when initialized with array API representation") {
				initShouldFail(value: [AnyObject](), type: Double.self)
			}

			context("when initialized with dictionary API representation") {
				initShouldFail(value: [String: AnyObject](), type: Double.self)
			}

		}

		describe("Bool") {

			context("when initialized with bool API representation") {
				initShouldSucceed(value: false, expected: false)
			}

			context("when initialized with integer API representation") {
				initShouldFail(value: 1.2, type: Bool.self)
			}

			context("when initialized with double API representation") {
				initShouldFail(value: 3, type: Bool.self)
			}

			context("when initialized with null API representation") {
				initShouldFail(value: NSNull(), type: Bool.self)
			}

			context("when initialized with string API representation") {
				initShouldFail(value: "foo", type: Bool.self)
			}

			context("when initialized with array API representation") {
				initShouldFail(value: [AnyObject](), type: Bool.self)
			}

			context("when initialized with dictionary API representation") {
				initShouldFail(value: [String: AnyObject](), type: Bool.self)
			}

		}

		describe("String") {

			context("when initialized with string API representation") {
				initShouldSucceed(value: "bar", expected: "bar")
			}

			context("when initialized with integer API representation") {
				initShouldFail(value: 1.2, type: String.self)
			}

			context("when initialized with double API representation") {
				initShouldFail(value: 3, type: String.self)
			}
			
			context("when initialized with bool API representation") {
				initShouldFail(value: true, type: String.self)
			}

			context("when initialized with null API representation") {
				initShouldFail(value: NSNull(), type: String.self)
			}

			context("when initialized with array API representation") {
				initShouldFail(value: [AnyObject](), type: String.self)
			}

			context("when initialized with dictionary API representation") {
				initShouldFail(value: [String: AnyObject](), type: String.self)
			}

		}

	}

}
