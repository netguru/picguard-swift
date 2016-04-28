//
// Dictionary.swift
//
// Copyright (c) 2016 Netguru Sp. z o.o. All rights reserved.
// Licensed under the MIT License.
//

internal extension Dictionary {

	/// Applies the mapping transform over `self`.
	///
	/// - Parameter transform: The transformation function.
	///
	/// - Throws: Rethrows whatever error was thrown by the transform function.
	///
	/// - Returns: A `Dictionary` containing the results of mapping `transform`
	/// over the values of `self`.
	func map<T>(@noescape transform: (Value) throws -> T) rethrows -> [Key: T] {
		var memo = Dictionary<Key, T>(minimumCapacity: count)
		try self.forEach { memo[$0] = try transform($1) }
		return memo
	}

}
