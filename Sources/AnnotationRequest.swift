//
// Picguard.swift
//
// Copyright (c) 2016 Netguru Sp. z o.o. All rights reserved.
// Licensed under the MIT License.
//

import UIKit

/// Describes type which creates Google Cloud Vision API request body in JSON.
public struct AnnotationRequest {

	/// Describes errors which may occur while composing request.
	public enum Error: ErrorType {

		/// Thrown if the features set is empty.
		case EmptyFeaturesSet
	}

	/// Detection operations which are run against image.
	///
	/// - Parameter maxResults: Indicates the maximum number of results
	/// to return for this feature type.
	///
	/// - Note: The API can return fewer results.
	public enum Feature {

		/// Execute Image Content Analysis on the entire image and return.
		case Label(maxResults: Int)

		/// Perform Optical Character Recognition (OCR) on text within the image.
		case Text(maxResults: Int)

		/// Detect faces within the image.
		case Face(maxResults: Int)

		/// Detect geographic landmarks within the image.
		case Landmark(maxResults: Int)

		/// Detect company logos within the image.
		case Logo(maxResults: Int)

		/// Determine image safe search properties on the image.
		case SafeSearch(maxResults: Int)

		/// Compute a set of properties about the image (such as the image's dominant colors).
		case ImageProperties(maxResults: Int)

		/// JSON dictionary representation of `Feature`.
		///
		/// - Returns: A Dictionary with `String` keys and `AnyObject` values.
		var JSONDictionaryRepresentation: [String: AnyObject] {
			switch self {
			case .Label(maxResults: let maxResults):
				return ["type": "LABEL_DETECTION", "maxResults": maxResults]
			case .Text(maxResults: let maxResults):
				return ["type": "TEXT_DETECTION", "maxResults": maxResults]
			case .Face(maxResults: let maxResults):
				return ["type": "FACE_DETECTION", "maxResults": maxResults]
			case .Landmark(maxResults: let maxResults):
				return ["type": "LANDMARK_DETECTION", "maxResults": maxResults]
			case .Logo(maxResults: let maxResults):
				return ["type": "LOGO_DETECTION", "maxResults": maxResults]
			case .SafeSearch(maxResults: let maxResults):
				return ["type": "SAFE_SEARCH_DETECTION", "maxResults": maxResults]
			case .ImageProperties(maxResults: let maxResults):
				return ["type": "IMAGE_PROPERTIES", "maxResults": maxResults]
			}
		}
	}

	/// Image representation which is used for detection operations.
	public enum Image {

		/// The Google Cloud Storage URI to the image.
		case URL(String)

		/// UIImage representation of image.
		case Image(UIImage)

		/// Data representation of image.
		case Data(NSData)

		/// JSON dictionary representation of `Image`.
		///
		/// - Throws: Errors from `Base64ImageEncoder.Error` domain
		/// if encoder fails to encode UIImage of NSData.
		///
		/// - Returns: A Dictionary with `String` keys and `AnyObject` values.
		func JSONDictionaryRepresentation(encoder: ImageEncoding) throws -> [String: AnyObject] {
			switch self {
			case .URL(let URL):
				return ["source": ["gcs_image_uri": URL]]
			case .Image(let image):
				return try ["content": encoder.encode(image: image)]
			case .Data(let data):
				return try ["content": encoder.encode(imageData: data)]
			}
		}
	}

	/// Set of features which are run against the image.
	public let features: Set<Feature>

	/// Image on detection operations are performed.
	public let image: Image

	/// Initializes the AnnotationRequest with image and a set of features
	///
	/// - Throws: EmptyFeaturesSet if provided features set is empty.
	///
	/// - Parameter features: Set of features to initialize the request with.
	///
	/// - Parameter image: Image to initialize the request with.
	public init(features: Set<Feature>, image: Image) throws {
		guard !features.isEmpty else {
			throw Error.EmptyFeaturesSet
		}
		self.features = features
		self.image = image
	}

	/// JSON dictionary representation of `AnnotationRequest`.
	///
	/// - Throws: Errors from `Base64ImageEncoder.Error` domain
	/// if encoder fails to encode UIImage of NSData.
	///
	/// - Returns: A Dictionary with `String` keys and `AnyObject` values.
	public func JSONDictionaryRepresentation(encoder: ImageEncoding) throws -> [String: AnyObject] {
		return [
			"image": try image.JSONDictionaryRepresentation(encoder),
			"features": features.map { $0.JSONDictionaryRepresentation }
		]
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
