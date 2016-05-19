//
// Location.swift
//
// Copyright (c) 2016 Netguru Sp. z o.o. All rights reserved.
// Licensed under the MIT License.
//

/// An object representing a latitude/longitude pair. This is expressed as a
/// pair of doubles representing degrees latitude and degrees longitude. Unless
/// specified otherwise, this must conform to the WGS84 standard.
public struct Location: APIRepresentationConvertible {

	/// The latitude in degrees (-90...90).
	public let latitude: Double

	/// The longitude in degrees (-180...180).
	public let longitude: Double

	// MARK: Errors

	/// Describes errors which can be thrown inside this type.
	public enum Error: ErrorType {

		/// Thrown if the latitude is not in the correct range.
		case InvalidLatitude

		/// Thrown if the longitude is not in the correct range.
		case InvalidLongitude

	}

	// MARK: Initializers

	/// Initializes the receiver with raw values.
	///
	/// - Parameters:
	///     - latitude: The latitude in degrees.
	///     - longitude: The longitude in degrees.
	///
	/// - Throws: Errors from `Location.Error` domain if latitude or longitude
	///   are not in valid range.
	public init(latitude: Double, longitude: Double) throws {
		guard -90...90 ~= latitude else {
			throw Error.InvalidLatitude
		}
		guard -180...180 ~= longitude else {
			throw Error.InvalidLongitude
		}
		self.latitude = latitude
		self.longitude = longitude
	}

	/// - SeeAlso: APIRepresentationConvertible.init(APIRepresentationValue:)
	public init(APIRepresentationValue value: APIRepresentationValue) throws {
		try self.init(
			latitude: value.get("latLng").get("latitude"),
			longitude: value.get("latLng").get("longitude")
		)
	}

}

// MARK: -

extension Location: Equatable {}

/// - SeeAlso: Equatable.==
public func == (lhs: Location, rhs: Location) -> Bool {
	return (
		lhs.latitude == rhs.latitude &&
		lhs.longitude == rhs.longitude
	)
}
