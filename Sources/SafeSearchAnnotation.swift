//
// LabelAnnotation.swift
//
// Copyright (c) 2016 Netguru Sp. z o.o. All rights reserved.
// Licensed under the MIT License.
//

public struct SafeSearchAnnotation: APIRepresentationConvertible {

	let adultLikelihood: Likelihood
	let spoofLikelihood: Likelihood
	let medicalLikelihood: Likelihood
	let violenceLikelihood: Likelihood

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
