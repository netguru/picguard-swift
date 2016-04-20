//
// DummySpec.swift
//
// Copyright (c) 2016 Netguru Sp. z o.o. All rights reserved.
// Licensed under the MIT License.
//

import Nimble
import Quick

@testable import Picguard

final class DummySpec: QuickSpec {
	
	override func spec() {
		
		it("should know the answer to the whole universe") {
			expect(dummyAnswerToTheUniverse()).to(equal(42))
		}
		
	}
	
}
