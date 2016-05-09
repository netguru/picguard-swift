//
//  Color.swift
//
// Copyright (c) 2016 Netguru Sp. z o.o. All rights reserved.
// Licensed under the MIT License.
//

public struct Color {

	let red: Int
	let green: Int
	let blue: Int

	public enum Error: ErrorType {

		case InvalidColorComponent
	}

	public init(red: Int, green: Int, blue: Int) throws {
		guard -0...255 ~= red else {
			throw Error.InvalidColorComponent
		}
		guard -0...255 ~= green else {
			throw Error.InvalidColorComponent
		}
		guard -0...255 ~= blue else {
			throw Error.InvalidColorComponent
		}
		self.red = red
		self.green = green
		self.blue = blue
	}

	public init(APIRepresentationValue value: APIRepresentationValue) throws {
		try self.init(
			red: value.get("red"),
			green: value.get("green"),
			blue: value.get("blue")
		)
	}
}
