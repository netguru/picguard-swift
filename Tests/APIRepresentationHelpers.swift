//
// APIRepresentationHelpers.swift
//
// Copyright (c) 2016 Netguru Sp. z o.o. All rights reserved.
// Licensed under the MIT License.
//

import Nimble
import Quick
import Picguard

func initWithAPIRepresentationShouldSucceed<T: protocol<Equatable, APIRepresentationConvertible>>(value value: AnyObject, expected: T) {
	it("should properly initialize the receiver") {
		expect {
			try T(APIRepresentationValue: APIRepresentationValue(value: value))
		}.to(equal(expected))
	}
}

func initWithAPIRepresentationShouldFail<T: APIRepresentationConvertible, E: ErrorType>(value value: AnyObject, type: T.Type, error: E) {
	it("should throw error") {
		expect {
			try T(APIRepresentationValue: APIRepresentationValue(value: value))
		}.to(throwError(error))
	}
}
