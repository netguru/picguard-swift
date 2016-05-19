//
// Picguard.playground
//
// Copyright (c) 2016 Netguru Sp. z o.o. All rights reserved.
// Licensed under the MIT License.
//

import UIKit
import Picguard
import XCPlayground

XCPlaygroundPage.currentPage.needsIndefiniteExecution = true

//: ### Configuration
//:
//: Begin by creating a `Picguard` instance with your Google API key.

let picguard = Picguard(APIKey: "<#Your API Key#>")

//: ### Providing images
//:
//: There are three possible ways to privide an image for `Picguard`:
//:
//: 1. `.Image` – if you have loaded an image in memory,
//: 2. `.Data` – if you have loaded image data in memory,
//: 3. `.URL` – to Google Cloud Storage, ifyou already uploaded an image

let _: AnnotationRequest.Image = .Image([#Image(imageLiteral: "Desert.png")#])
let _: AnnotationRequest.Image = .Data(NSData())
let _: AnnotationRequest.Image = .URL("https://storage.googleapis.com/bucket/object")

//: ### Detecting unsafe content
//:
//: If your app is a service which allows users to upload photos, you may often
//: need a **NSFW filter** to reject pictures containing **adult content**,
//: **violence**, **spoof** and **medical content**.
//:
//: Picguard offers a unified method for checking all of above categories and
//: uses an algorithm to calculate an average likelihood of NSFW content:

let image1: AnnotationRequest.Image = .Image([#Image(imageLiteral: "Gun.png")#])

picguard.detectUnsafeContentLikelihood(image: image1) { result in
	switch result {
		case .Success(let likelihood):
			"Likelihood of NSFW content: \(likelihood)"
		case .Error(let error):
			"Annotation failed with error: \(error)"
	}
}

//: ### Detecting face presence likelihood
//:
//: Sometimes you may need to know whether a photo **contains any faces**. For
//: such case, `Picguard` offers a simple method to calculate a likelihood of
//: any face being present in a picture:

let image2: AnnotationRequest.Image = .Image([#Image(imageLiteral: "Steve.png")#])

picguard.detectFacePresenceLikelihood(image: image2) { result in
	switch result {
		case .Success(let likelihood):
			"Likelihood of face presence: \(likelihood)"
		case .Error(let error):
			"Annotation failed with error: \(error)"
	}
}

//: Advanced annotation
//:
//: As `Picguard` is a **fully featured Google Cloud Vision API client**, you
//: may compose your own requests that are not covered by above helpers and
//: interpret the results your way:

let image3: AnnotationRequest.Image = .Image([#Image(imageLiteral: "Eiffel.png")#])

picguard.annotate(image: image3, features: [
	.Label(maxResults: 5),
	.Landmark(maxResults: 2),
	.ImageProperties
]) { result in
	switch result {
		case .Success(let response):
			"Label annotations: \(response.labelAnnotations)"
			"Landmark annotations: \(response.landmarkAnnotations)"
			"Image properties annotation: \(response.imagePropertiesAnnotation)"
		case .Error(let error):
			"Annotation failed with error: \(error)"
	}
}

//: ### Try it yourself!
//:
//: Now is your turn to try `Picguard` for yourself!

picguard
