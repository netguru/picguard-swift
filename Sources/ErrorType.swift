//
// Dictionary.swift
//
// Copyright (c) 2016 Netguru Sp. z o.o. All rights reserved.
// Licensed under the MIT License.
//

import Foundation

/// - SeeAlso: Equatable.==
internal func == (lhs: ErrorType, rhs: ErrorType) -> Bool {
	switch (lhs, rhs) {
		case let (lhs as APIClient.Error, rhs as APIClient.Error):
			return lhs == rhs
		case let (lhs as AnnotationRequest.Error, rhs as AnnotationRequest.Error):
			return lhs == rhs
		case let (lhs as APIRepresentationError, rhs as APIRepresentationError):
			return lhs == rhs
		case let (lhs as Base64ImageEncoder.Error, rhs as Base64ImageEncoder.Error):
			return lhs == rhs
		case let (lhs as FaceAnnotation.Error, rhs as FaceAnnotation.Error):
			return lhs == rhs
		case let (lhs as FaceLandmarkType.Error, rhs as FaceLandmarkType.Error):
			return lhs == rhs
		case let (lhs as LabelAnnotation.Error, rhs as LabelAnnotation.Error):
			return lhs == rhs
		case let (lhs as Likelihood.Error, rhs as Likelihood.Error):
			return lhs == rhs
		case let (lhs as NSError, rhs as NSError):
			return lhs.domain == rhs.domain && lhs.code == rhs.code
		default: return false
	}
}
