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

		describe("Int") {

			context("when initialized with integer API representation") {
				initWithAPIRepresentationShouldSucceed(value: 1, expected: 1)
			}

			context("when initialized with double API representation") {
				initWithAPIRepresentationShouldSucceed(value: 2.3, expected: Int(2.3))
			}

			context("when initialized with null API representation") {
				initWithAPIRepresentationShouldFail(value: NSNull(), type: Int.self, error: APIRepresentationError.UnexpectedValueType)
			}

			context("when initialized with bool API representation") {
				initWithAPIRepresentationShouldFail(value: true, type: Int.self, error: APIRepresentationError.UnexpectedValueType)
			}

			context("when initialized with string API representation") {
				initWithAPIRepresentationShouldFail(value: "foo", type: Int.self, error: APIRepresentationError.UnexpectedValueType)
			}

			context("when initialized with array API representation") {
				initWithAPIRepresentationShouldFail(value: [AnyObject](), type: Int.self, error: APIRepresentationError.UnexpectedValueType)
			}

			context("when initialized with dictionary API representation") {
				initWithAPIRepresentationShouldFail(value: [String: AnyObject](), type: Int.self, error: APIRepresentationError.UnexpectedValueType)
			}

		}

		describe("Double") {

			context("when initialized with integer API representation") {
				initWithAPIRepresentationShouldSucceed(value: 1.2, expected: 1.2)
			}

			context("when initialized with double API representation") {
				initWithAPIRepresentationShouldSucceed(value: 3, expected: Double(3))
			}

			context("when initialized with null API representation") {
				initWithAPIRepresentationShouldFail(value: NSNull(), type: Double.self, error: APIRepresentationError.UnexpectedValueType)
			}

			context("when initialized with bool API representation") {
				initWithAPIRepresentationShouldFail(value: true, type: Double.self, error: APIRepresentationError.UnexpectedValueType)
			}

			context("when initialized with string API representation") {
				initWithAPIRepresentationShouldFail(value: "foo", type: Double.self, error: APIRepresentationError.UnexpectedValueType)
			}

			context("when initialized with array API representation") {
				initWithAPIRepresentationShouldFail(value: [AnyObject](), type: Double.self, error: APIRepresentationError.UnexpectedValueType)
			}

			context("when initialized with dictionary API representation") {
				initWithAPIRepresentationShouldFail(value: [String: AnyObject](), type: Double.self, error: APIRepresentationError.UnexpectedValueType)
			}

		}

		describe("Bool") {

			context("when initialized with bool API representation") {
				initWithAPIRepresentationShouldSucceed(value: false, expected: false)
			}

			context("when initialized with integer API representation") {
				initWithAPIRepresentationShouldFail(value: 1.2, type: Bool.self, error: APIRepresentationError.UnexpectedValueType)
			}

			context("when initialized with double API representation") {
				initWithAPIRepresentationShouldFail(value: 3, type: Bool.self, error: APIRepresentationError.UnexpectedValueType)
			}

			context("when initialized with null API representation") {
				initWithAPIRepresentationShouldFail(value: NSNull(), type: Bool.self, error: APIRepresentationError.UnexpectedValueType)
			}

			context("when initialized with string API representation") {
				initWithAPIRepresentationShouldFail(value: "foo", type: Bool.self, error: APIRepresentationError.UnexpectedValueType)
			}

			context("when initialized with array API representation") {
				initWithAPIRepresentationShouldFail(value: [AnyObject](), type: Bool.self, error: APIRepresentationError.UnexpectedValueType)
			}

			context("when initialized with dictionary API representation") {
				initWithAPIRepresentationShouldFail(value: [String: AnyObject](), type: Bool.self, error: APIRepresentationError.UnexpectedValueType)
			}

		}

		describe("String") {

			context("when initialized with string API representation") {
				initWithAPIRepresentationShouldSucceed(value: "bar", expected: "bar")
			}

			context("when initialized with integer API representation") {
				initWithAPIRepresentationShouldFail(value: 1.2, type: String.self, error: APIRepresentationError.UnexpectedValueType)
			}

			context("when initialized with double API representation") {
				initWithAPIRepresentationShouldFail(value: 3, type: String.self, error: APIRepresentationError.UnexpectedValueType)
			}
			
			context("when initialized with bool API representation") {
				initWithAPIRepresentationShouldFail(value: true, type: String.self, error: APIRepresentationError.UnexpectedValueType)
			}

			context("when initialized with null API representation") {
				initWithAPIRepresentationShouldFail(value: NSNull(), type: String.self, error: APIRepresentationError.UnexpectedValueType)
			}

			context("when initialized with array API representation") {
				initWithAPIRepresentationShouldFail(value: [AnyObject](), type: String.self, error: APIRepresentationError.UnexpectedValueType)
			}

			context("when initialized with dictionary API representation") {
				initWithAPIRepresentationShouldFail(value: [String: AnyObject](), type: String.self, error: APIRepresentationError.UnexpectedValueType)
			}

		}

	}

}
