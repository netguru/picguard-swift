import UIKit
import Picguard
import XCPlayground

XCPlaygroundPage.currentPage.needsIndefiniteExecution = true

let APIKey = "" // Enter your Google Cloud Vision API key
let picguard = Picguard(APIKey: APIKey)

picguard.detectUnsafeContent(image: UIImage(named: "dog")!) { result in
	if case .Success(let unsafeContentLikelihood) = result {
		switch unsafeContentLikelihood {
			case .VeryUnlikely: print("It is very unlikely that this image has unsafe content.")
			case .Unlikely: print("It is unlikely that this image has unsafe content.")
			case .Possible: print("It is possible that this image has unsafe content.")
			case .Likely: print("It is likely that this image has unsafe content.")
			case .VeryLikely: print("It is very likely that this image has unsafe content.")
			case .Unknown: print("Don't know whether that this image has unsafe content.")
		}
		XCPlaygroundPage.currentPage.finishExecution()
	}
}
