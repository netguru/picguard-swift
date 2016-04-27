//
// Picguard.swift
//
// Copyright (c) 2016 Netguru Sp. z o.o. All rights reserved.
// Licensed under the MIT License.
//

import UIKit

public struct AnnotationRequest {

	public enum `Type` {
		case Face(maxResults: Int)
	}

	public enum Image {
		case URL(String)
		case Image(UIImage)
		var JSONRepresentation: [String: Any] {
			return [:]
		}
	}

	public let types: Set<`Type`>
	public let image: Image

	public init(types: Set<`Type`>, image: Image) {
		self.types = types
		self.image = image
	}

	var JSONRepresentation: [String: Any] {
		return [:]
	}
}

extension AnnotationRequest.`Type`: Hashable {
	public var hashValue: Int {
		switch self {
		case .Face: return 1
		}
	}
}

public func == (lhs: AnnotationRequest.`Type`, rhs: AnnotationRequest.`Type`) -> Bool {
	switch (lhs, rhs) {
	case (.Face, .Face):
		return true
	}
}
