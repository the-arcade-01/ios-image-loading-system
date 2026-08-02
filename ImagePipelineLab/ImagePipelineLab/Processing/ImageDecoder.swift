//
//  ImageDecoder.swift
//  ImagePipelineLab
//
//  Created by arcade on 01/08/26.
//

import Foundation
import SwiftUI

struct ImageDecoder: ImageProcessing {
	func process(_ input: Data) throws -> UIImage {
		guard let image = UIImage(data: input) else {
			throw ImageLoadingError.decodingFailed
		}
		return image
	}
}
