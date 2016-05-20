//
// AnnotationRequest.swift
//
// Copyright (c) 2016 Netguru Sp. z o.o. All rights reserved.
// Licensed under the MIT License.
//

/// Describes type which creates Google Cloud Vision API request body in JSON.
public struct AnnotationRequest {

	// MARK: Errors

	/// Describes errors which may occur while composing request.
	public enum Error: ErrorType {

		/// Thrown if the feature set is empty.
		case EmptyFeatureSet
	}

	// MARK: Nested Enums

	/// Detection operations which are run against image.
	///
	/// - Note: The API can return fewer results.
	public enum Feature {

		/// Detect faces within the image.
		///
		/// - Parameter maxResults: Optionally constraints the maximum number of
		///   results to return for this feature type. When `nil`, all results
		///   will be returned.
		case Face(maxResults: Int?)

		/// Execute Image Content Analysis on the entire image and return.
		///
		/// - Parameter maxResults: Optionally constraints the maximum number of
		///   results to return for this feature type. When `nil`, all results
		///   will be returned.
		case Label(maxResults: Int?)

		/// Detect geographic landmarks within the image.
		///
		/// - Parameter maxResults: Optionally constraints the maximum number of
		///   results to return for this feature type. When `nil`, all results
		///   will be returned.
		case Landmark(maxResults: Int?)

		/// Detect company logos within the image.
		///
		/// - Parameter maxResults: Optionally constraints the maximum number of
		///   results to return for this feature type. When `nil`, all results
		///   will be returned.
		case Logo(maxResults: Int?)

		/// Perform Optical Character Recognition (OCR) on text within the image.
		case Text

		/// Determine image safe search properties on the image.
		case SafeSearch

		/// Compute a set of properties about the image.
		case ImageProperties

		// MARK: JSON Representation

		/// JSON dictionary representation of `Feature`.
		var JSONDictionaryRepresentation: [String: AnyObject] {
			switch self {
				case .Face(let maxResults):
					return compact(["type": "FACE_DETECTION", "maxResults": maxResults])
				case .Label(let maxResults):
					return compact(["type": "LABEL_DETECTION", "maxResults": maxResults])
				case .Landmark(let maxResults):
					return compact(["type": "LANDMARK_DETECTION", "maxResults": maxResults])
				case .Logo(let maxResults):
					return compact(["type": "LOGO_DETECTION", "maxResults": maxResults])
				case .Text:
					return ["type": "TEXT_DETECTION"]
				case .SafeSearch:
					return ["type": "SAFE_SEARCH_DETECTION"]
				case .ImageProperties:
					return ["type": "IMAGE_PROPERTIES"]
			}
		}

	}

	/// Image representation which is used for detection operations.
	public enum Image {

		/// The Google Cloud Storage URI to the image.
		case URL(String)

		/// Platform specyfic ImageType representation of image.
		case Image(Base64EncodableImage)

		/// Base 64 string representation of image data.
		case Base64String(String)

		// MARK: JSON Representation

		/// JSON dictionary representation of `Image`.
		///
		/// - Throws: Rethrows any errors thrown by `ImageEncoding` when encoder
		///   fails to encode image to data.
		///
		/// - Returns: A Dictionary with `String` keys and `AnyObject` values.
		func JSONDictionaryRepresentation() throws -> [String: AnyObject] {
			switch self {
				case .URL(let URL):
					return ["source": ["gcs_image_uri": URL]]
				case .Image(let image):
					return ["content": try image.base64EncodedStringRepresentation()]
				case .Base64String(let string):
					return ["content": string]
			}
		}
	}

	/// Set of features which are run against the image.
	public let features: Set<Feature>

	/// Image on detection operations are performed.
	public let image: Image

	// MARK: Initializers

	/// Initializes the AnnotationRequest with image and a set of features
	///
	/// - Throws: `EmptyFeatureSet` error if provided features set is empty.
	///
	/// - Parameter features: Set of features to initialize the request with.
	///
	/// - Parameter image: Image to initialize the request with.
	public init(features: Set<Feature>, image: Image) throws {
		guard !features.isEmpty else {
			throw Error.EmptyFeatureSet
		}
		self.features = features
		self.image = image
	}

	// MARK: JSON Representation

	/// JSON dictionary representation of `AnnotationRequest`.
	///
	/// - Throws: Rethrows any errors thrown by `ImageEncoding`
	///   when encoder fails to encode image to data.
	///
	/// - Returns: A Dictionary with `String` keys and `AnyObject` values.
	public func JSONDictionaryRepresentation() throws -> [String: AnyObject] {
		return [
			"image": try image.JSONDictionaryRepresentation(),
			"features": features.map { $0.JSONDictionaryRepresentation }
		]
	}
}

// MARK: -

extension AnnotationRequest: Equatable {}

/// - SeeAlso: Equatable.==
public func == (lhs: AnnotationRequest, rhs: AnnotationRequest) -> Bool {
	return lhs.features == rhs.features && lhs.image == rhs.image
}

// MARK: -

extension AnnotationRequest.Feature: Equatable {}

/// - SeeAlso: Equatable.==
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

// MARK: -

extension AnnotationRequest.Feature: Hashable {

	/// - SeeAlso: Hashable.hashValue
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

// MARK: -

extension AnnotationRequest.Image: Equatable {}

/// - SeeAlso: Equatable.==
public func == (lhs: AnnotationRequest.Image, rhs: AnnotationRequest.Image) -> Bool {
	switch (lhs, rhs) {
		case let (.URL(lhsURL), .URL(rhsURL)):
			return lhsURL == rhsURL
		case let (.Image(lhsImage), .Image(rhsImage)):
			do {
				return try lhsImage.base64EncodedStringRepresentation() == rhsImage.base64EncodedStringRepresentation()
			} catch {
				return false
		}
		case let (.Base64String(lhsString), .Base64String(rhsString)):
			return lhsString == rhsString
		default: return false
	}
}
