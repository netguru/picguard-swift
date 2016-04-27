import Picguard
import UIKit

let set = Set<AnnotationRequest.`Type`>([.Face(maxResults: 1)])
let image = AnnotationRequest.Image.Image(UIImage())
let request = AnnotationRequest(types: set, image: image)
let client = APIClient(key: "fixture api key")
client.perform(request: request) { result in
	switch result {
	case let .Success(response): print("success, response: \(response)")
	case let .Error(error): print("error, response: \(error)")
	}
}