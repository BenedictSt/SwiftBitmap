//
//  Copyright © 2023 Darren Ford. All rights reserved.
//
//  MIT license
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated
//  documentation files (the "Software"), to deal in the Software without restriction, including without limitation the
//  rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to
//  permit persons to whom the Software is furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all copies or substantial
//  portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
//  WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS
//  OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
//  OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

import Foundation
import CoreGraphics

fileprivate extension CGColorSpace {
	static let csRGB = CGColorSpace(name: CGColorSpace.sRGB)!
}

public extension CGColor {
	#if !os(macOS)
	static let clear = CGColor(red: 0, green: 0, blue: 0, alpha: 0)
	static let black = CGColor(colorSpace: .init(name: CGColorSpace.linearGray)!, components: [0, 1])!
	static let white = CGColor(colorSpace: .init(name: CGColorSpace.linearGray)!, components: [1, 1])!
	#endif

	static let red = CGColor(colorSpace: CGColorSpace.csRGB, components: [1.0, 0.0, 0.0, 1.0])!
	static let green = CGColor(colorSpace: CGColorSpace.csRGB, components: [0.0, 1.0, 0.0, 1.0])!
	static let blue = CGColor(colorSpace: CGColorSpace.csRGB, components: [0.0, 0.0, 1.0, 1.0])!
	static let yellow = CGColor(colorSpace: CGColorSpace.csRGB, components: [1.0, 1.0, 0.0, 1.0])!
	static let magenta = CGColor(colorSpace: CGColorSpace.csRGB, components: [1.0, 0.0, 1.0, 1.0])!
	static let cyan = CGColor(colorSpace: CGColorSpace.csRGB, components: [0.0, 1.0, 1.0, 1.0])!
}

public extension Bitmap.RGBA {
	/// Create an RGBA color from a cgColor, converting the colorspace if necessary
	/// - Parameter cgColor: The color
	init(_ cgColor: CGColor) throws {
		var color = cgColor
		if cgColor.colorSpace?.name != CGColorSpace.sRGB {
			guard let c = color.converted(to: CGColorSpace.csRGB, intent: .defaultIntent, options: nil) else {
				throw Bitmap.BitmapError.cannotConvertColorSpace
			}
			color = c
		}
		guard
			let components = color.components,
			components.count == 4
		else { throw Bitmap.BitmapError.cannotConvertColorSpace }
		self.init(rf: components[0], gf: components[1], bf: components[2], af: components[3])
	}
}
