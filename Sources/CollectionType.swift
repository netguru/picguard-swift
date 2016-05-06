//
// Dictionary.swift
//
// Copyright (c) 2016 Netguru Sp. z o.o. All rights reserved.
// Licensed under the MIT License.
//

/// - SeeAlso: Equatable.==
internal func ==<C: CollectionType where C.Generator.Element: Equatable>
	(lhs: C?, rhs: C?) -> Bool {
	switch (lhs, rhs) {
	case (.Some(let lhs), .Some(let rhs)):
		return lhs == rhs
	case (.None, .None):
		return true
	default:
		return false
	}
}
