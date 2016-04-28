//
// Picguard.swift
//
// Copyright (c) 2016 Netguru Sp. z o.o. All rights reserved.
// Licensed under the MIT License.
//

import UIKit

public struct AnnotationRequest {

	public enum Feature {
		case Label(maxResults: Int)
		case Text(maxResults: Int)
		case Face(maxResults: Int)
		case Landmark(maxResults: Int)
		case Logo(maxResults: Int)
		case SafeSearch(maxResults: Int)
		case ImageProperties(maxResults: Int)

		var JSONRepresentation: [String: Any] {
			switch self {
			case .Label(maxResults: let maxResults):
				return ["type":"LABEL_DETECTION",
				        "maxResults":maxResults]
			case .Text(maxResults: let maxResults):
				return ["type":"TEXT_DETECTION",
				        "maxResults":maxResults]
			case .Face(maxResults: let maxResults):
				return ["type":"FACE_DETECTION",
				        "maxResults":maxResults]
			case .Landmark(maxResults: let maxResults):
				return ["type":"LANDMARK_DETECTION",
				        "maxResults":maxResults]
			case .Logo(maxResults: let maxResults):
				return ["type":"LOGO_DETECTION",
				        "maxResults":maxResults]
			case .SafeSearch(maxResults: let maxResults):
				return ["type":"SAFE_SEARCH_DETECTION",
				        "maxResults":maxResults]
			case .ImageProperties(maxResults: let maxResults):
				return ["type":"IMAGE_PROPERTIES",
				        "maxResults":maxResults]
			}
		}
	}

	public enum Image {
		case URL(String)
		case Image(UIImage)
		case Data(NSData)

		var JSONRepresentation: [String: Any] {
			switch self {
			case .URL(let URL):
				return ["source": ["gcs_image_uri": URL]]
			case .Image(_):
				return ["content": "encoded image"]
			case .Data(_):
				return ["content": "encoded image data"]
			}
		}
	}

	public let types: Set<Feature>
	public let image: Image

	public init(types: Set<Feature>, image: Image) {
		self.types = types
		self.image = image
	}

	var JSONRepresentation: [String: Any] {
		return ["image": image,
		        "features": Array(types)]
	}
}

// MARK: - Hashable

extension AnnotationRequest.Feature: Hashable {
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

// MARK: - Equatable

public func == (lhs: AnnotationRequest.Feature, rhs: AnnotationRequest.Feature) -> Bool {
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
