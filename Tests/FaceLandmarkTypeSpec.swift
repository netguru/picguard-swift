//
// FaceLandmarkTypeSpec.swift
//
// Copyright (c) 2016 Netguru Sp. z o.o. All rights reserved.
// Licensed under the MIT License.
//

import Nimble
import Quick
import Picguard

final class FaceLandmarkTypeSpec: QuickSpec {

	override func spec() {

		describe("FaceLandmarkType") {

			func initWithStringShouldSucceed(string string: String, expected: FaceLandmarkType) {
				it("should properly initialize the receiver") {
					expect {
						try FaceLandmarkType(string: string)
					}.to(equal(expected))
				}
			}

			func initWithStringShouldFail(string string: String) {
				it("should fail to initialize") {
					expect {
						try FaceLandmarkType(string: string)
					}.to(throwError(FaceLandmarkType.Error.InvalidStringValue))
				}
			}

			describe("init with string") {

				context("with valid string") {

					context("representing UNKNOWN_LANDMARK landmark") {
						initWithStringShouldSucceed(string: "UNKNOWN_LANDMARK", expected: .Unknown)
					}

					context("representing LEFT_EYE landmark") {
						initWithStringShouldSucceed(string: "LEFT_EYE", expected: .LeftEye)
					}

					context("representing RIGHT_EYE landmark") {
						initWithStringShouldSucceed(string: "RIGHT_EYE", expected: .RightEye)
					}

					context("representing LEFT_OF_LEFT_EYEBROW landmark") {
						initWithStringShouldSucceed(string: "LEFT_OF_LEFT_EYEBROW", expected: .LeftOfLeftEyebrow)
					}

					context("representing RIGHT_OF_LEFT_EYEBROW landmark") {
						initWithStringShouldSucceed(string: "RIGHT_OF_LEFT_EYEBROW", expected: .RightOfLeftEyebrow)
					}

					context("representing LEFT_OF_RIGHT_EYEBROW landmark") {
						initWithStringShouldSucceed(string: "LEFT_OF_RIGHT_EYEBROW", expected: .LeftOfRightEyebrow)
					}

					context("representing RIGHT_OF_RIGHT_EYEBROW landmark") {
						initWithStringShouldSucceed(string: "RIGHT_OF_RIGHT_EYEBROW", expected: .RightOfRightEyebrow)
					}

					context("representing MIDPOINT_BETWEEN_EYES landmark") {
						initWithStringShouldSucceed(string: "MIDPOINT_BETWEEN_EYES", expected: .MidpointBetweenEyes)
					}

					context("representing NOSE_TIP landmark") {
						initWithStringShouldSucceed(string: "NOSE_TIP", expected: .NoseTip)
					}

					context("representing UPPER_LIP landmark") {
						initWithStringShouldSucceed(string: "UPPER_LIP", expected: .UpperLip)
					}

					context("representing LOWER_LIP landmark") {
						initWithStringShouldSucceed(string: "LOWER_LIP", expected: .LowerLip)
					}

					context("representing MOUTH_LEFT landmark") {
						initWithStringShouldSucceed(string: "MOUTH_LEFT", expected: .MouthLeft)
					}

					context("representing MOUTH_RIGHT landmark") {
						initWithStringShouldSucceed(string: "MOUTH_RIGHT", expected: .MouthRight)
					}

					context("representing MOUTH_CENTER landmark") {
						initWithStringShouldSucceed(string: "MOUTH_CENTER", expected: .MouthCenter)
					}

					context("representing NOSE_BOTTOM_RIGHT landmark") {
						initWithStringShouldSucceed(string: "NOSE_BOTTOM_RIGHT", expected: .NoseBottomRight)
					}

					context("representing NOSE_BOTTOM_LEFT landmark") {
						initWithStringShouldSucceed(string: "NOSE_BOTTOM_LEFT", expected: .NoseBottomLeft)
					}

					context("representing NOSE_BOTTOM_CENTER landmark") {
						initWithStringShouldSucceed(string: "NOSE_BOTTOM_CENTER", expected: .NoseBottomCenter)
					}

					context("representing LEFT_EYE_TOP_BOUNDARY landmark") {
						initWithStringShouldSucceed(string: "LEFT_EYE_TOP_BOUNDARY", expected: .LeftEyeTopBoundary)
					}

					context("representing LEFT_EYE_RIGHT_CORNER landmark") {
						initWithStringShouldSucceed(string: "LEFT_EYE_RIGHT_CORNER", expected: .LeftEyeRightCorner)
					}

					context("representing LEFT_EYE_BOTTOM_BOUNDARY landmark") {
						initWithStringShouldSucceed(string: "LEFT_EYE_BOTTOM_BOUNDARY", expected: .LeftEyeBottomBoundary)
					}

					context("representing LEFT_EYE_LEFT_CORNER landmark") {
						initWithStringShouldSucceed(string: "LEFT_EYE_LEFT_CORNER", expected: .LeftEyeLeftCorner)
					}

					context("representing RIGHT_EYE_TOP_BOUNDARY landmark") {
						initWithStringShouldSucceed(string: "RIGHT_EYE_TOP_BOUNDARY", expected: .RightEyeTopBoundary)
					}

					context("representing RIGHT_EYE_RIGHT_CORNER landmark") {
						initWithStringShouldSucceed(string: "RIGHT_EYE_RIGHT_CORNER", expected: .RightEyeRightCorner)
					}

					context("representing RIGHT_EYE_BOTTOM_BOUNDARY landmark") {
						initWithStringShouldSucceed(string: "RIGHT_EYE_BOTTOM_BOUNDARY", expected: .RightEyeBottomBoundary)
					}

					context("representing RIGHT_EYE_LEFT_CORNER landmark") {
						initWithStringShouldSucceed(string: "RIGHT_EYE_LEFT_CORNER", expected: .RightEyeLeftCorner)
					}

					context("representing LEFT_EYEBROW_UPPER_MIDPOINT landmark") {
						initWithStringShouldSucceed(string: "LEFT_EYEBROW_UPPER_MIDPOINT", expected: .LeftEyebrowUpperMidpoint)
					}

					context("representing RIGHT_EYEBROW_UPPER_MIDPOINT landmark") {
						initWithStringShouldSucceed(string: "RIGHT_EYEBROW_UPPER_MIDPOINT", expected: .RightEyebrowUpperMidpoint)
					}

					context("representing LEFT_EAR_TRAGION landmark") {
						initWithStringShouldSucceed(string: "LEFT_EAR_TRAGION", expected: .LeftEarTragion)
					}

					context("representing RIGHT_EAR_TRAGION landmark") {
						initWithStringShouldSucceed(string: "RIGHT_EAR_TRAGION", expected: .RightEarTragion)
					}

					context("representing LEFT_EYE_PUPIL landmark") {
						initWithStringShouldSucceed(string: "LEFT_EYE_PUPIL", expected: .LeftEyePupil)
					}

					context("representing RIGHT_EYE_PUPIL landmark") {
						initWithStringShouldSucceed(string: "RIGHT_EYE_PUPIL", expected: .RightEyePupil)
					}

					context("representing FOREHEAD_GLABELLA landmark") {
						initWithStringShouldSucceed(string: "FOREHEAD_GLABELLA", expected: .ForeheadGlabella)
					}

					context("representing CHIN_GNATHION landmark") {
						initWithStringShouldSucceed(string: "CHIN_GNATHION", expected: .ChinGnathion)
					}

					context("representing CHIN_LEFT_GONION landmark") {
						initWithStringShouldSucceed(string: "CHIN_LEFT_GONION", expected: .ChinLeftGonion)
					}

					context("representing CHIN_RIGHT_GONION landmark") {
						initWithStringShouldSucceed(string: "CHIN_RIGHT_GONION", expected: .ChinRightGonion)
					}

				}

				context("with invalid string") {
					initWithStringShouldFail(string: "FOO")
				}

			}

			describe("init with api representation") {

				context("with valid string") {
					initWithAPIRepresentationShouldSucceed(value: "UNKNOWN_LANDMARK", expected: FaceLandmarkType.Unknown)
				}

				context("with invalid string") {
					initWithAPIRepresentationShouldFail(value: "BAR", type: FaceLandmarkType.self, error: FaceLandmarkType.Error.InvalidStringValue)
				}

				context("with invalid representation value type") {
					initWithAPIRepresentationShouldFail(value: true, type: FaceLandmarkType.self, error: APIRepresentationError.UnexpectedValueType)
				}

			}

		}

	}

}
