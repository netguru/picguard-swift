//
// Base64ImageEncoderSpec.swift
//
// Copyright (c) 2016 Netguru Sp. z o.o. All rights reserved.
// Licensed under the MIT License.
//

import Nimble
import Quick
import Picguard

final class Base64ImageEncoderSpec: QuickSpec {

	override func spec() {

		var sut: Base64ImageEncoder!

		beforeEach {
			sut = Base64ImageEncoder()
		}

		afterEach {
			sut = nil
		}

		describe("encode image") {

			var encodedImage: String!
			var image: UIImage!

			context("when image can be encoded to valid data") {

				beforeEach {
					image = UIImage(size: CGSize(width: 1, height: 1), color: .yellowColor())
					encodedImage = try! sut.encode(image: image)
				}

				it("should return base64 encoded image string") {
					let decodedData = NSData(base64EncodedString: encodedImage, options: [])
					expect(decodedData).to(equal(UIImagePNGRepresentation(image)))
				}
			}

			context("when image cannot be encoded to valid data") {

				beforeEach {
					image = UIImage()
				}

				it("should throw unsupported bitmap data error") {
					expect {
						try sut.encode(image: image)
					}.to(throwError(Base64ImageEncoder.Error.UnsupportedBitmapData))
				}
			}
		}

		describe("encode image data") {

			var encodedImage: String!
			var imageData: NSData!

			context("when image data can be converted to valid image") {
				
				beforeEach {
					let image = UIImage(size: CGSize(width: 1, height: 1), color: .yellowColor())
					imageData = UIImagePNGRepresentation(image)
					encodedImage = try! sut.encode(imageData: imageData)
				}

				it("should return base64 encoded image data string") {
					let decodedData = NSData(base64EncodedString: encodedImage, options: [])
					expect(decodedData).to(equal(imageData))
				}
			}

			context("when image data cannot be converted to valid image") {

				beforeEach {
					imageData = NSData()
				}

				it("should throw invalid image data error") {
					expect {
						try sut.encode(imageData: imageData)
					}.to(throwError(Base64ImageEncoder.Error.InvalidImageData))
				}
			}
		}
	}
}

// MARK: -

private extension UIImage {

	convenience init(size: CGSize, color: UIColor) {
		let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
		UIGraphicsBeginImageContext(rect.size)
		let context = UIGraphicsGetCurrentContext()
		CGContextSetFillColorWithColor(context, color.CGColor)
		CGContextFillRect(context, rect)
		let image = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
		let renderedImage = image.imageWithRenderingMode(.AlwaysOriginal)
		self.init(data: UIImagePNGRepresentation(renderedImage)!)!
	}
}
