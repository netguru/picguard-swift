//
// FaceDetectionResult.swift
//
// Copyright (c) 2016 Netguru Sp. z o.o. All rights reserved.
// Licensed under the MIT License.
//

public struct FaceAnnotation: APIRepresentationConvertible {

	/// The bounding polygon around the face, computed to "frame" the face in
	/// accordance with human expectations. Based on landmarker results.
	public let boundingPolygon: BoundingPolygon

	/// The bouning polygon that encloses only the skin part of the face. It is
	/// tighter than the `boundingPolygon` and it is used to eliminate the face
	/// from any image analysis. Not based on landmarker results.
	public let skinBoundingPolygon: BoundingPolygon

	/// Detected face landmarks.
	public let landmarks: [FaceLandmark]

	/// Rotation of the face relative to the image vertical (-180...180).
	public let rollAngle: Double

	/// Indicates the leftward/rightward angle that the face is pointing,
	/// relative to the vertical plane perpendicular to the image (-180...180).
	public let panAngle: Double

	/// Indicates the upwards/downwards angle that the face is pointing relative
	/// to the image's horizontal plane (-180...180).
	public let tiltAngle: Double

	/// Confidence of the detection (0...1).
	public let detectionConfidence: Double

	/// Confidence of the landmarking (0...1).
	public let landmarkingConfidence: Double

	/// Likelihood of face showing joy emotion.
	public let joyLikelihood: Likelihood

	/// Likelihood of face showing sorrow emotion.
	public let sorrowLikelihood: Likelihood

	/// Likelihood of face showing anger emotion.
	public let angerLikelihood: Likelihood

	/// Likelihood of face showing surprise emotion.
	public let surpriseLikelihood: Likelihood

	/// Likelihood of face being under-exposed.
	public let underExposedLikelihood: Likelihood

	/// Likelihood of face being blurred.
	public let blurredLikelihood: Likelihood

	/// Likelihood of face wearing headwear.
	public let headwearLikelihood: Likelihood

	// MARK: Errors

	/// Describes errors which can be thrown inside this type.
	public enum Error: ErrorType {

		/// Thrown if roll angle is not in the correct range.
		case InvalidRollAngle

		/// Thrown if pan angle is not in the correct range.
		case InvalidPanAngle

		/// Thrown if tilt angle is not in the correct range.
		case InvalidTiltAngle

		/// Thrown if detection confidence is not in the correct range.
		case InvalidDetectionConfidence

		/// Thrown if landmarking confidence is not in the correct range.
		case InvalidLandmarkingConfidence

	}

	// MARK: Initializers

	// swiftlint:disable function_parameter_count

	/// Initializes the receiver with raw values.
	///
	/// - Parameters:
	///     - boundingPolygon: The bounding polygon around the face.
	///     - skinBoundingPolygon: The skin bouning polygon.
	///     - landmarks: Detected face landmarks.
	///     - rollAngle: Rotation of the face.
	///     - panAngle: Leftward/rightward angle of the face.
	///     - tiltAngle: Upwards/downwards angle of the face.
	///     - detectionConfidence: Confidence of the detection.
	///     - landmarkingConfidence: Confidence of the landmarking.
	///     - joyLikelihood: Joy emotion likelihood.
	///     - sorrowLikelihood: Sorrow emotion likelihood.
	///     - angerLikelihood: Anger emotion likelihood.
	///     - surpriseLikelihood: Surprise emotion likelihood.
	///     - underExposedLikelihood: Likelohood of being under-exposed.
	///     - blurredLikelihood: Likelihood of being blurred.
	///     - headwearLikelihood: Likelihood of headwear.
	///
	/// - Throws: Errors from `FaceAnnotation.Error` domain if the provided
	/// numeric values are out of their expected range.
	public init(
		boundingPolygon: BoundingPolygon,
		skinBoundingPolygon: BoundingPolygon,
		landmarks: [FaceLandmark],
		rollAngle: Double,
		panAngle: Double,
		tiltAngle: Double,
		detectionConfidence: Double,
		landmarkingConfidence: Double,
		joyLikelihood: Likelihood,
		sorrowLikelihood: Likelihood,
		angerLikelihood: Likelihood,
		surpriseLikelihood: Likelihood,
		underExposedLikelihood: Likelihood,
		blurredLikelihood: Likelihood,
		headwearLikelihood: Likelihood
	) throws {
		guard -180...180 ~= rollAngle else {
			throw Error.InvalidRollAngle
		}
		guard -180...180 ~= panAngle else {
			throw Error.InvalidPanAngle
		}
		guard -180...180 ~= tiltAngle else {
			throw Error.InvalidTiltAngle
		}
		guard 0...1 ~= detectionConfidence else {
			throw Error.InvalidDetectionConfidence
		}
		guard 0...1 ~= landmarkingConfidence else {
			throw Error.InvalidLandmarkingConfidence
		}
		self.boundingPolygon = boundingPolygon
		self.skinBoundingPolygon = skinBoundingPolygon
		self.landmarks = landmarks
		self.rollAngle = rollAngle
		self.panAngle = panAngle
		self.tiltAngle = tiltAngle
		self.detectionConfidence = detectionConfidence
		self.landmarkingConfidence = landmarkingConfidence
		self.joyLikelihood = joyLikelihood
		self.sorrowLikelihood = sorrowLikelihood
		self.angerLikelihood = angerLikelihood
		self.surpriseLikelihood = surpriseLikelihood
		self.underExposedLikelihood = underExposedLikelihood
		self.blurredLikelihood = blurredLikelihood
		self.headwearLikelihood = headwearLikelihood
	}

	// swiftlint:enable function_parameter_count

	/// - SeeAlso: APIRepresentationConvertible.init(APIRepresentationValue:)
	public init(APIRepresentationValue value: APIRepresentationValue) throws {
		try self.init(
			boundingPolygon: value.get("boundingPoly"),
			skinBoundingPolygon: value.get("fdBoundingPoly"),
			landmarks: value.get("landmarks"),
			rollAngle: value.get("rollAngle"),
			panAngle: value.get("panAngle"),
			tiltAngle: value.get("tiltAngle"),
			detectionConfidence: value.get("detectionConfidence"),
			landmarkingConfidence: value.get("landmarkingConfidence"),
			joyLikelihood: value.get("joyLikelihood"),
			sorrowLikelihood: value.get("sorrowLikelihood"),
			angerLikelihood: value.get("angerLikelihood"),
			surpriseLikelihood: value.get("surpriseLikelihood"),
			underExposedLikelihood: value.get("underExposedLikelihood"),
			blurredLikelihood: value.get("blurredLikelihood"),
			headwearLikelihood: value.get("headwearLikelihood")
		)
	}

}

// MARK: -

extension FaceAnnotation: Equatable {}

/// - SeeAlso: Equatable.==
public func == (lhs: FaceAnnotation, rhs: FaceAnnotation) -> Bool {
	return (
		lhs.boundingPolygon == rhs.boundingPolygon &&
		lhs.skinBoundingPolygon == rhs.skinBoundingPolygon &&
		lhs.landmarks == rhs.landmarks &&
		lhs.rollAngle == rhs.rollAngle &&
		lhs.panAngle == rhs.panAngle &&
		lhs.tiltAngle == rhs.tiltAngle &&
		lhs.detectionConfidence == rhs.detectionConfidence &&
		lhs.landmarkingConfidence == rhs.landmarkingConfidence &&
		lhs.joyLikelihood == rhs.joyLikelihood &&
		lhs.sorrowLikelihood == rhs.sorrowLikelihood &&
		lhs.angerLikelihood == rhs.angerLikelihood &&
		lhs.surpriseLikelihood == rhs.surpriseLikelihood &&
		lhs.underExposedLikelihood == rhs.underExposedLikelihood &&
		lhs.blurredLikelihood == rhs.blurredLikelihood &&
		lhs.headwearLikelihood == rhs.headwearLikelihood
	)
}
