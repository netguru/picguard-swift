import UIKit
import Picguard
import XCPlayground

XCPlaygroundPage.currentPage.needsIndefiniteExecution = true

// Enter your Google Cloud Vision API key
let picguard = Picguard(APIKey: "foobar")

let anImage = AnnotationRequest.Image.Image(UIImage(named: "portrait")!)

picguard.detectUnsafeContentLikelihood(image: anImage) { result in
	switch result {
	case .Success(let likelihood):
		print("Likelihood of NSFW content: \(likelihood)")
	case .Error(let error):
		print("Error detecting NSFW content: \(error)")
	}
}

picguard.detectFacePresenceLikelihood(image: anImage) { result in
	switch result {
	case .Success(let likelihood):
		print("Likelihood of face presence: \(likelihood)")
	case .Error(let error):
		print("Error detecting face presence: \(error)")
	}
}

picguard.annotate(image: anImage, features: [
	.Face(maxResults: 2),
	.Label(maxResults: 5),
	.Landmark(maxResults: 3)
]) { result in
	switch result {
	case .Success(let response):
		print("Face annotations: \(response.faceAnnotations)")
		print("Label annotations: \(response.labelAnnotations)")
		print("Landmark annotations: \(response.landmarkAnnotations)")
	case .Error(let error):
		print("Error analyzing image: \(error)")
	}
}
