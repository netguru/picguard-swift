//
// FaceLandmarkType.swift
//
// Copyright (c) 2016 Netguru Sp. z o.o. All rights reserved.
// Licensed under the MIT License.
//

/// Face landmark type. Left and right are defined from the vantage of the
/// viewer of the image, without considering mirror projections typical of
/// photos. So, .LeftEye, typically is the person's right eye.
public enum FaceLandmarkType: APIRepresentationConvertible {

	/// Unknown face landmark detected.
	case Unknown

	/// Left eye.
	case LeftEye

	/// Right eye.
	case RightEye

	/// Midpoint between eyes.
	case MidpointBetweenEyes

	/// Left eye pupil.
	case LeftEyePupil

	/// Right eye pupil.
	case RightEyePupil

	/// Left eye, left corner.
	case LeftEyeLeftCorner

	/// Left eye, top boundary.
	case LeftEyeTopBoundary

	/// Left eye, right corner.
	case LeftEyeRightCorner

	/// Left eye, bottom boundary.
	case LeftEyeBottomBoundary

	/// Right eye, left corner.
	case RightEyeLeftCorner

	/// Right eye, top boundary.
	case RightEyeTopBoundary

	/// Right eye, right corner.
	case RightEyeRightCorner

	/// Right eye, bottom boundary.
	case RightEyeBottomBoundary

	/// Left of left eyebrow.
	case LeftOfLeftEyebrow

	/// Right of left eyebrow.
	case RightOfLeftEyebrow

	/// Left of right eyebrow.
	case LeftOfRightEyebrow

	/// Right of right eyebrow.
	case RightOfRightEyebrow

	/// Left eyebrow, upper midpoint.
	case LeftEyebrowUpperMidpoint

	/// Right eyebrow, upper midpoint.
	case RightEyebrowUpperMidpoint

	/// 	Nose tip.
	case NoseTip

	/// Upper lip.
	case UpperLip

	/// Lower lip.
	case LowerLip

	/// Left of mouth.
	case MouthLeft

	/// Center of mouth.
	case MouthCenter

	/// Right of mouth.
	case MouthRight

	/// Nose, bottom left.
	case NoseBottomLeft

	/// Nose, bottom center.
	case NoseBottomCenter

	/// Nose, bottom right.
	case NoseBottomRight

	/// 	Left ear tragion.
	case LeftEarTragion

	/// Right ear tragion.
	case RightEarTragion

	/// Forehead glabella.
	case ForeheadGlabella

	/// Chin gnathion.
	case ChinGnathion

	/// Chin left gonion.
	case ChinLeftGonion

	/// Chin right gonion.
	case ChinRightGonion

	// MARK: Errors

	/// Describes errors which can be thrown inside this type.
	public enum Error: ErrorType {

		/// Thrown if representation string is invalid.
		case InvalidStringValue
	}

	// MARK: Initializers

	/// Initializes the receiver with a string.
	///
	/// - Parameter string: The string representation of the receiver.
	///
	/// - Throws: `Error.InvalidStringValue` if the string is invalid.
	init(string: String) throws {
		switch string {
			case "UNKNOWN_LANDMARK": self = .Unknown
			case "LEFT_EYE": self = .LeftEye
			case "RIGHT_EYE": self = .RightEye
			case "LEFT_OF_LEFT_EYEBROW": self = .LeftOfLeftEyebrow
			case "RIGHT_OF_LEFT_EYEBROW": self = .RightOfLeftEyebrow
			case "LEFT_OF_RIGHT_EYEBROW": self = .LeftOfRightEyebrow
			case "RIGHT_OF_RIGHT_EYEBROW": self = .RightOfRightEyebrow
			case "MIDPOINT_BETWEEN_EYES": self = .MidpointBetweenEyes
			case "NOSE_TIP": self = .NoseTip
			case "UPPER_LIP": self = .UpperLip
			case "LOWER_LIP": self = .LowerLip
			case "MOUTH_LEFT": self = .MouthLeft
			case "MOUTH_RIGHT": self = .MouthRight
			case "MOUTH_CENTER": self = .MouthCenter
			case "NOSE_BOTTOM_RIGHT": self = .NoseBottomRight
			case "NOSE_BOTTOM_LEFT": self = .NoseBottomLeft
			case "NOSE_BOTTOM_CENTER": self = .NoseBottomCenter
			case "LEFT_EYE_TOP_BOUNDARY": self = .LeftEyeTopBoundary
			case "LEFT_EYE_RIGHT_CORNER": self = .LeftEyeRightCorner
			case "LEFT_EYE_BOTTOM_BOUNDARY": self = .LeftEyeBottomBoundary
			case "LEFT_EYE_LEFT_CORNER": self = .LeftEyeLeftCorner
			case "RIGHT_EYE_TOP_BOUNDARY": self = .RightEyeTopBoundary
			case "RIGHT_EYE_RIGHT_CORNER": self = .RightEyeRightCorner
			case "RIGHT_EYE_BOTTOM_BOUNDARY": self = .RightEyeBottomBoundary
			case "RIGHT_EYE_LEFT_CORNER": self = .RightEyeLeftCorner
			case "LEFT_EYEBROW_UPPER_MIDPOINT": self = .LeftEyebrowUpperMidpoint
			case "RIGHT_EYEBROW_UPPER_MIDPOINT": self = .RightEyebrowUpperMidpoint
			case "LEFT_EAR_TRAGION": self = .LeftEarTragion
			case "RIGHT_EAR_TRAGION": self = .RightEarTragion
			case "LEFT_EYE_PUPIL": self = .LeftEyePupil
			case "RIGHT_EYE_PUPIL": self = .RightEyePupil
			case "FOREHEAD_GLABELLA": self = .ForeheadGlabella
			case "CHIN_GNATHION": self = .ChinGnathion
			case "CHIN_LEFT_GONION": self = .ChinLeftGonion
			case "CHIN_RIGHT_GONION": self = .ChinRightGonion
			default: throw Error.InvalidStringValue
		}
	}

	/// - SeeAlso: APIRepresentationConvertible.init(APIRepresentationValue:)
	public init(APIRepresentationValue value: APIRepresentationValue) throws {
		guard case .String(let string) = value else {
			throw APIRepresentationError.UnexpectedValueType
		}
		try self.init(string: string)
	}

}
