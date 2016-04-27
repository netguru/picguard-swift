//
// FaceDetectionResult.swift
//
// Copyright (c) 2016 Netguru Sp. z o.o. All rights reserved.
// Licensed under the MIT License.
//

public struct FaceAnnotation {

	/// The bounding polygon around the face, computed to "frame" the face in
	/// accordance with human expectations. Based on landmarker results.
	public let boundingPolygon: BoundingPolygon

	/// The bouning polygon that encloses only the skin part of the face. It is
	/// tighter than the `boundingPolygon` and it is used to eliminate the face
	/// from any image analysis. Not based on landmarker results.
	public let skinBoundingPolygon: BoundingPolygon

	/// Rotation of the face relative to the image vertical (-180...180).
	public let rollAngle: Double

	/// Indicates the leftward/rightward angle that the face is pointing,
	/// relative to the vertical plane perpendicular to the image (-180...180).
	public let panAngle: Double

	/// Indicates the upwards/downwards angle that the face is pointing relative
	/// to the image's horizontal plane (-180...180).
	public let tiltAngle: Double

}
