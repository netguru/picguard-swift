//
// LabelAnnotation.swift
//
// Copyright (c) 2016 Netguru Sp. z o.o. All rights reserved.
// Licensed under the MIT License.
//

/// Describes the result of safe search detection.
public struct SafeSearchAnnotation: APIRepresentationConvertible {

	/// Likelihood of image containing adult contents.
	let adultLikelihood: Likelihood

	/// Likelihood that an obvious modification was made to the image's canonical version
	/// to make it appear funny or offensive.
	let spoofLikelihood: Likelihood

	/// Likelihood of image containing medical content.
	let medicalLikelihood: Likelihood

	/// Likelihood of image containing violence content.
	let violenceLikelihood: Likelihood

	// MARK: Initializers

	/// Initializes the receiver with raw values.
	///
	/// - Parameters:
	///     - adultLikelihood: Likelihood of adult content.
	///     - spoofLikelihood: Likelihood of spoof content.
	///     - medicalLikelihood: Likelihood of medical content.
	///     - violenceLikelihood: Likelihood of violence content.
	public init(
		adultLikelihood: Likelihood,
		spoofLikelihood: Likelihood,
		medicalLikelihood: Likelihood,
		violenceLikelihood: Likelihood
	) {
		self.adultLikelihood = adultLikelihood
		self.spoofLikelihood = spoofLikelihood
		self.medicalLikelihood = medicalLikelihood
		self.violenceLikelihood = violenceLikelihood
	}

	/// - SeeAlso: APIRepresentationConvertible.init(APIRepresentationValue:)
	public init(APIRepresentationValue value: APIRepresentationValue) throws {
		try self.init(
			adultLikelihood: value.get("adult"),
			spoofLikelihood: value.get("spoof"),
			medicalLikelihood: value.get("medical"),
			violenceLikelihood: value.get("violence")
		)
	}
}

// MARK: -

extension SafeSearchAnnotation: Equatable {}

/// - SeeAlso: Equatable.==
public func == (lhs: SafeSearchAnnotation, rhs: SafeSearchAnnotation) -> Bool {
	return (
		lhs.adultLikelihood == rhs.adultLikelihood &&
		lhs.spoofLikelihood == rhs.spoofLikelihood &&
		lhs.medicalLikelihood == rhs.medicalLikelihood &&
		lhs.violenceLikelihood == rhs.violenceLikelihood
	)
}
