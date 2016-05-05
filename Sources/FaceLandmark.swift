//
// FaceLandmark.swift
//
// Copyright (c) 2016 Netguru Sp. z o.o. All rights reserved.
// Licensed under the MIT License.
//

/// A face-specific landmark. Landmark positions may fall outside the bounds of
/// the image when the face is near one or more edges of the image.
public struct FaceLandmark: APIRepresentationConvertible {

	/// Face landmark type.
	public let type: FaceLandmarkType

	/// Face landmark position.
	public let position: Position

	// MARK: Initializers

	/// Initializes the receiver with raw values.
	///
	/// - Parameters:
	///     - type: Face landmark type.
	///     - position: Face landmark position.
	public init(type: FaceLandmarkType, position: Position) {
		self.type = type
		self.position = position
	}

	/// - SeeAlso: APIRepresentationConvertible.init(APIRepresentationValue:)
	public init(APIRepresentationValue value: APIRepresentationValue) throws {
		try self.init(
			type: value.get("type"),
			position: value.get("position")
		)
	}

}

// MARK: -


}
