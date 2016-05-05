//
// FaceAnnotationSpec.swift
//
// Copyright (c) 2016 Netguru Sp. z o.o. All rights reserved.
// Licensed under the MIT License.
//

import Nimble
import Quick
import Picguard

final class FaceAnnotationSpec: QuickSpec {

	override func spec() {

		describe("FaceAnnotation") {

			func initWithRawValuesShouldSucceed(
				values values: (
					rollAngle: Double,
					panAngle: Double,
					tiltAngle: Double,
					detectionConfidence: Double,
					landmarkingConfidence: Double
				)
			) {
				it("should properly initialize the receiver") {
					expect {
						try FaceAnnotation(
							boundingPolygon: BoundingPolygon(vertices: []),
							skinBoundingPolygon: BoundingPolygon(vertices: []),
							landmarks: [],
							rollAngle: values.rollAngle,
							panAngle: values.panAngle,
							tiltAngle: values.tiltAngle,
							detectionConfidence: values.detectionConfidence,
							landmarkingConfidence: values.landmarkingConfidence,
							joyLikelihood: .Unknown,
							sorrowLikelihood: .Unknown,
							angerLikelihood: .Unknown,
							surpriseLikelihood: .Unknown,
							underExposedLikelihood: .Unknown,
							blurredLikelihood: .Unknown,
							headwearLikelihood: .Unknown
						)
					}.toNot(throwError())
				}
			}

			func initWithRawValuesShouldFail<E: ErrorType>(
				values values: (
					rollAngle: Double,
					panAngle: Double,
					tiltAngle: Double,
					detectionConfidence: Double,
					landmarkingConfidence: Double
				),
				error: E
			) {
				it("should throw error") {
					expect {
						try FaceAnnotation(
							boundingPolygon: BoundingPolygon(vertices: []),
							skinBoundingPolygon: BoundingPolygon(vertices: []),
							landmarks: [],
							rollAngle: values.rollAngle,
							panAngle: values.panAngle,
							tiltAngle: values.tiltAngle,
							detectionConfidence: values.detectionConfidence,
							landmarkingConfidence: values.landmarkingConfidence,
							joyLikelihood: .Unknown,
							sorrowLikelihood: .Unknown,
							angerLikelihood: .Unknown,
							surpriseLikelihood: .Unknown,
							underExposedLikelihood: .Unknown,
							blurredLikelihood: .Unknown,
							headwearLikelihood: .Unknown
						)
					}.to(throwError(error))
				}
			}

			describe("init with raw values") {

				context("with all numeric values being valid") {
					initWithRawValuesShouldSucceed(values: (
						rollAngle: 30,
						panAngle: -60,
						tiltAngle: 120,
						detectionConfidence: 0.5,
						landmarkingConfidence: 0.5
					))
				}

				context("with invalid roll angle") {
					initWithRawValuesShouldFail(values: (
						rollAngle: 200,
						panAngle: 0,
						tiltAngle: 0,
						detectionConfidence: 0,
						landmarkingConfidence: 0
					), error: FaceAnnotation.Error.InvalidRollAngle)
				}

				context("with invalid pan angle") {
					initWithRawValuesShouldFail(values: (
						rollAngle: 0,
						panAngle: -300,
						tiltAngle: 0,
						detectionConfidence: 0,
						landmarkingConfidence: 0
					), error: FaceAnnotation.Error.InvalidPanAngle)
				}

				context("with invalid tilt angle") {
					initWithRawValuesShouldFail(values: (
						rollAngle: 0,
						panAngle: 0,
						tiltAngle: 400,
						detectionConfidence: 0,
						landmarkingConfidence: 0
					), error: FaceAnnotation.Error.InvalidTiltAngle)
				}

				context("with invalid detection confidence") {
					initWithRawValuesShouldFail(values: (
						rollAngle: 0,
						panAngle: 0,
						tiltAngle: 0,
						detectionConfidence: 2,
						landmarkingConfidence: 0
					), error: FaceAnnotation.Error.InvalidDetectionConfidence)
				}

				context("with invalid landmarking confidence") {
					initWithRawValuesShouldFail(values: (
						rollAngle: 0,
						panAngle: 0,
						tiltAngle: 0,
						detectionConfidence: 0,
						landmarkingConfidence: -3
					), error: FaceAnnotation.Error.InvalidLandmarkingConfidence)
				}

			}

			describe("init with api representation") {

				context("with valid dictionary") {
					initWithAPIRepresentationShouldSucceed(value: [
						"boundingPoly": ["vertices": [["x": 1, "y": 2]]],
						"fdBoundingPoly": ["vertices": [["x": 3, "y": 4]]],
						"landmarks": [["type": "UNKNOWN_LANDMARK", "position": ["x": 5, "y": 6, "z": 7]]],
						"rollAngle": 30,
						"panAngle": 60,
						"tiltAngle": 120,
						"detectionConfidence": 0.25,
						"landmarkingConfidence": 0.75,
						"joyLikelihood": "UNKNOWN",
						"sorrowLikelihood": "UNKNOWN",
						"angerLikelihood": "UNKNOWN",
						"surpriseLikelihood": "UNKNOWN",
						"underExposedLikelihood": "UNKNOWN",
						"blurredLikelihood": "UNKNOWN",
						"headwearLikelihood": "UNKNOWN"
					], expected: try! FaceAnnotation(
						boundingPolygon: BoundingPolygon(vertices: [Vertex(x: 1, y: 2)]),
						skinBoundingPolygon: BoundingPolygon(vertices: [Vertex(x: 3, y: 4)]),
						landmarks: [FaceLandmark(type: .Unknown, position: Position(x: 5, y: 6, z: 7))],
						rollAngle: 30,
						panAngle: 60,
						tiltAngle: 120,
						detectionConfidence: 0.25,
						landmarkingConfidence: 0.75,
						joyLikelihood: .Unknown,
						sorrowLikelihood: .Unknown,
						angerLikelihood: .Unknown,
						surpriseLikelihood: .Unknown,
						underExposedLikelihood: .Unknown,
						blurredLikelihood: .Unknown,
						headwearLikelihood: .Unknown
					))
				}

				context("with invalid representation value type") {
					initWithAPIRepresentationShouldFail(
						value: "foobar",
						type: FaceAnnotation.self,
						error: APIRepresentationError.UnexpectedValueType
					)
				}

			}

		}
		
	}
	
}
