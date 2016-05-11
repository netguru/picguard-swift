//
// PicguardSpec.swift
//
// Copyright (c) 2016 Netguru Sp. z o.o. All rights reserved.
// Licensed under the MIT License.
//

import Nimble
import Quick
import Picguard

final class PicguardSpec: QuickSpec {

	override func spec() {

		var sut: Picguard!

		beforeEach {
			sut = Picguard(APIClient: APIClient(APIKey: "", encoder: Base64ImageEncoder()))
		}

		afterEach {
			sut = nil
		}

		it("should pass") {
		}
	}
}
