//
// Picguard.swift
//
// Copyright (c) 2016 Netguru Sp. z o.o. All rights reserved.
// Licensed under the MIT License.
//

import UIKit

public struct AnnotationRequest {

	public enum `Type` {
		case Label(maxResults: Int)
		case Text(maxResults: Int)
		case Face(maxResults: Int)
		case Landmark(maxResults: Int)
		case Logo(maxResults: Int)
		case SafeSearch(maxResults: Int)
		case ImageProperties(maxResults: Int)

		var JSONRepresentation: [String: Any] {
			return [:]
		}
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
		case .Label: return 1
		case .Text: return 2
		case .Face: return 3
		case .Landmark: return 4
		case .Logo: return 5
		case .SafeSearch: return 6
		case .ImageProperties: return 7
		}
	}
}

public func == (lhs: AnnotationRequest.`Type`, rhs: AnnotationRequest.`Type`) -> Bool {
	switch (lhs, rhs) {
	case (.Label, .Label): return true
	case (.Text, .Text): return true
	case (.Face, .Face): return true
	case (.Landmark, .Landmark): return true
	case (.Logo, .Logo): return true
	case (.SafeSearch, .SafeSearch): return true
	case (.ImageProperties, .ImageProperties): return true
	default: return false
	}
}
