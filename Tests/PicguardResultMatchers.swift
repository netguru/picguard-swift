//
// PicguardResultMatchers.swift
//
// Copyright (c) 2016 Netguru Sp. z o.o. All rights reserved.
// Licensed under the MIT License.
//

import Nimble
import Quick
import Picguard

func beSuccessful<T>() -> NonNilMatcherFunc<PicguardResult<T>> {
	return NonNilMatcherFunc { expression, message in
		message.postfixMessage = "be successful"
		if let actual = try expression.evaluate() {
			if case .Success = actual {
				return true
			}
		}
		return false
	}
}

func beErroneus<T>() -> NonNilMatcherFunc<PicguardResult<T>> {
	return NonNilMatcherFunc { expression, message in
		message.postfixMessage = "be erroneus"
		if let actual = try expression.evaluate() {
			if case .Error = actual {
				return true
			}
		}
		return false
	}
}

func beSuccessful<T: Equatable>(expected: T) -> NonNilMatcherFunc<PicguardResult<T>> {
	return NonNilMatcherFunc { expression, message in
		message.postfixMessage = "be successful and equal <\(stringify(expected))>"
		if let actual = try expression.evaluate() {
			if case .Success(let value) = actual {
				return value == expected
			}
		}
		return false
	}
}

func beErroneus<T, E: ErrorType where E: Equatable>(expected: E) -> NonNilMatcherFunc<PicguardResult<T>> {
	return NonNilMatcherFunc { expression, message in
		message.postfixMessage = "be erroneus and equal <\(stringify(expected))>"
		if let actual = try expression.evaluate() {
			if case .Error(let error) = actual {
				if let error = error as? E {
					return error == expected
				}
			}
		}
		return false
	}
}
