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
	///   over the values of `self`.
	func map<T>(@noescape transform: (Value) throws -> T) rethrows -> [Key: T] {
		var memo = Dictionary<Key, T>(minimumCapacity: count)
		try self.forEach { memo[$0] = try transform($1) }
		return memo
	}

	/// Adds an element to the dictionary.
	///
	/// - Parameter element: An element to append. Will override value in `self`
	///   in case key already exists.
	///
	/// - Returns: A `Dictionary` containing values of `self` with appended
	///   `element`.
	func appending(element element: Generator.Element) -> [Key: Value] {
		var mutableSelf = self
		mutableSelf[element.0] = element.1
		return mutableSelf
	}

}

/// Compacts `dictionary` by removing `nil` values. Note: This is a free
/// function because a Swift doesn't support `Value`-constrained `Dictionary`
/// extensions (yet).
///
/// - Parameter dictionary: The dictionary to be compacted.
///
/// - Returns: A `Dictionary` containing non-`nil` values of input `dictionary`.
internal func compact<K, V>(dictionary: [K: V?]) -> [K: V] {
	return dictionary.reduce([:]) { memo, pair in
		if let value = pair.1 {
			return memo.appending(element: (pair.0, value))
		}
		return memo
	}
}
