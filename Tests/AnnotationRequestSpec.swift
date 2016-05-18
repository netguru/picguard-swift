//
// AnnotationRequestSpec.swift
//
// Copyright (c) 2016 Netguru Sp. z o.o. All rights reserved.
// Licensed under the MIT License.
//

import Nimble
import Quick
import Picguard

final class AnnotationRequestSpec: QuickSpec {

	override func spec() {

		var sut: AnnotationRequest!

		afterEach {
			sut = nil
		}

		context("when initialized with Image image type") {

			beforeEach {
				let features = Set([AnnotationRequest.Feature.Label(maxResults: 1)])
				let image = AnnotationRequest.Image.Image(UIImage())
				sut = try! AnnotationRequest.init(features: features, image: image)
			}

			describe("JSON dictionary representation") {

				var imageJSON: [String: AnyObject]!

				beforeEach {
					let JSON = try! sut.JSONDictionaryRepresentation(MockImageEncoder())
					imageJSON = JSON["image"] as! [String: AnyObject]
				}

				it("should have proper content") {
					expect(imageJSON["content"] as? String).to(equal("fixture encoded image"))
				}
				
			}

		}

		context("when initialized with Data image type") {

			beforeEach {
				let features = Set([AnnotationRequest.Feature.Label(maxResults: 1)])
				let image = AnnotationRequest.Image.Data(NSData())
				sut = try! AnnotationRequest.init(features: features, image: image)
			}

			describe("JSON dictionary representation") {

				var imageJSON: [String: AnyObject]!

				beforeEach {
					let JSON = try! sut.JSONDictionaryRepresentation(MockImageEncoder())
					imageJSON = JSON["image"] as! [String: AnyObject]
				}

				it("should have proper content") {
					expect(imageJSON["content"] as? String).to(equal("fixture encoded image data"))
				}

			}

		}

		context("when initialized with URL image type") {

			beforeEach {
				let features = Set([AnnotationRequest.Feature.Label(maxResults: 1)])
				let image = AnnotationRequest.Image.URL("fixture image url")
				sut = try! AnnotationRequest.init(features: features, image: image)
			}

			describe("JSON dictionary representation") {

				var imageJSON: [String: AnyObject]!

				beforeEach {
					let JSON = try! sut.JSONDictionaryRepresentation(MockImageEncoder())
					imageJSON = JSON["image"] as! [String: AnyObject]
				}

				describe("source") {

					var sourceJSON: [String: AnyObject]!

					beforeEach {
						sourceJSON = imageJSON["source"] as! [String: AnyObject]
					}

					it("should have proper Google Cloud Storage URI") {
						expect(sourceJSON["gcs_image_uri"] as? String).to(equal("fixture image url"))
					}

				}

			}

		}

		context("when initialized with single feature") {

			beforeEach {
				let features = Set([AnnotationRequest.Feature.Label(maxResults: 1)])
				let image = AnnotationRequest.Image.Image(UIImage())
				sut = try! AnnotationRequest.init(features: features, image: image)
			}

			describe("JSON dictionary representation") {

				var featuresJSON: [[String: AnyObject]]!

				beforeEach {
					let JSON = try! sut.JSONDictionaryRepresentation(MockImageEncoder())
					featuresJSON = JSON["features"] as! [[String: AnyObject]]
				}

				it("should have 1 feature") {
					expect(featuresJSON.count).to(equal(1))
				}

				describe("first feature") {

					var firstFeatureJSON: [String: AnyObject]!

					beforeEach {
						firstFeatureJSON = featuresJSON[0]
					}

					it("should be Label type") {
						expect(firstFeatureJSON["type"] as? String).to(equal("LABEL_DETECTION"))
					}

					it("should have max results 1") {
						expect(firstFeatureJSON["maxResults"] as? Int).to(equal(1))
					}

				}

			}

		}

		context("when initialized with multiple features") {

			context("when features don't repeat") {

				beforeEach {
					let features = Set([AnnotationRequest.Feature.SafeSearch,
						AnnotationRequest.Feature.ImageProperties(maxResults: 2),
						AnnotationRequest.Feature.Logo(maxResults: 3),
						AnnotationRequest.Feature.Text])
					let image = AnnotationRequest.Image.Image(UIImage())
					sut = try! AnnotationRequest.init(features: features, image: image)
				}

				describe("JSON dictionary representation") {

					var featuresJSON: [[String: AnyObject]]!

					beforeEach {
						let JSON = try! sut.JSONDictionaryRepresentation(MockImageEncoder())
						featuresJSON = JSON["features"] as! [[String: AnyObject]]
					}

					it("should have 4 features") {
						expect(featuresJSON.count).to(equal(4))
					}

					describe("first feature") {

						var firstFeatureJSON: [String: AnyObject]!

						beforeEach {
							firstFeatureJSON = featuresJSON[0]
						}

						it("should be SafeSearch type") {
							expect(firstFeatureJSON["type"] as? String).to(equal("SAFE_SEARCH_DETECTION"))
						}
						
					}

					describe("second feature") {

						var firstFeatureJSON: [String: AnyObject]!

						beforeEach {
							firstFeatureJSON = featuresJSON[1]
						}

						it("should be ImageProperties type") {
							expect(firstFeatureJSON["type"] as? String).to(equal("IMAGE_PROPERTIES"))
						}

						it("should have max results 2") {
							expect(firstFeatureJSON["maxResults"] as? Int).to(equal(2))
						}

					}

					describe("third feature") {

						var firstFeatureJSON: [String: AnyObject]!

						beforeEach {
							firstFeatureJSON = featuresJSON[2]
						}

						it("should be Logo type") {
							expect(firstFeatureJSON["type"] as? String).to(equal("LOGO_DETECTION"))
						}

						it("should have max results 3") {
							expect(firstFeatureJSON["maxResults"] as? Int).to(equal(3))
						}

					}

					describe("fourth feature") {

						var firstFeatureJSON: [String: AnyObject]!

						beforeEach {
							firstFeatureJSON = featuresJSON[3]
						}

						it("should be Text type") {
							expect(firstFeatureJSON["type"] as? String).to(equal("TEXT_DETECTION"))
						}

					}

				}

			}

			context("when features repeat") {

				var featuresJSON: [[String: AnyObject]]!

				beforeEach {
					let features = Set([AnnotationRequest.Feature.Face(maxResults: 4),
						AnnotationRequest.Feature.Face(maxResults: 3)])
					let image = AnnotationRequest.Image.Image(UIImage())
					sut = try! AnnotationRequest.init(features: features, image: image)
					let JSON = try! sut.JSONDictionaryRepresentation(MockImageEncoder())
					featuresJSON = JSON["features"] as! [[String: AnyObject]]
				}

				it("should have 1 feature") {
					expect(featuresJSON.count).to(equal(1))
				}

				describe("first feature") {

					var firstFeatureJSON: [String: AnyObject]!

					beforeEach {
						firstFeatureJSON = featuresJSON[0]
					}

					it("should be Face type") {
						expect(firstFeatureJSON["type"] as? String).to(equal("FACE_DETECTION"))
					}

					it("should have max results 3") {
						expect(firstFeatureJSON["maxResults"] as? Int).to(equal(3))
					}

				}

			}

		}

		context("when initialized with empty features set") {

			it("should thorw EmptyFeaturesSet error") {
				expect {
					try AnnotationRequest.init(features: Set(), image: .URL("fixture url"))
				}.to(throwError(AnnotationRequest.Error.EmptyFeaturesSet))
			}

		}

	}

}
