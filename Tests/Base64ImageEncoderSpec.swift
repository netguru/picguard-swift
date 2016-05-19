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
			var image: ImageType!

			context("when image can be encoded to valid data") {

				beforeEach {
					image = Image(size: CGSize(width: 1, height: 1), color: .yellowColor())
					encodedImage = try! sut.encode(image: image)
				}

				it("should return base64 encoded image string") {
					let decodedData = NSData(base64EncodedString: encodedImage, options: [])
					expect(decodedData).to(equal(PNGImageConverter().convert(image: image)))
				}

			}

			context("when image cannot be encoded to valid data") {

				beforeEach {
					image = Image()
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
					let image = Image(size: CGSize(width: 1, height: 1), color: .yellowColor())
					imageData = PNGImageConverter().convert(image: image)
					encodedImage = try! sut.encode(imageData: imageData)
				}

				it("should return base64 encoded image data string") {
					let decodedData = NSData(base64EncodedString: encodedImage, options: [])
					expect(decodedData).to(equal(imageData))
				}

			}


		}

	}

}

// MARK: -

#if os(iOS)
	typealias Image = UIImage

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
#endif

#if os(OSX)
	typealias Image = NSImage

	private extension NSImage {

		convenience init(size: CGSize, color: NSColor) {
			let colorSpace = CGColorSpaceCreateDeviceRGB()
			let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.PremultipliedLast.rawValue)
			let context = CGBitmapContextCreate(nil, Int(size.width), Int(size.height), 8, 0, colorSpace, bitmapInfo.rawValue)

			CGContextSetFillColorWithColor(context, NSColor.redColor().CGColor)
			CGContextFillRect(context, CGRect(x: 0, y: 0, width: size.width, height: size.height));

			let image = CGBitmapContextCreateImage(context)
			self.init(CGImage: image!, size: size)
		}
		
	}
#endif
