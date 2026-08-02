//
//  ResizeProcessor.swift
//  ImagePipelineLab
//
//  Created by arcade on 01/08/26.
//

import Foundation
import SwiftUI

nonisolated struct ResizeProcessor: ImageProcessing {
	let targetSize: CGSize

	func process(_ input: UIImage) throws -> UIImage {
		let renderer = UIGraphicsImageRenderer(size: targetSize)

		return renderer.image { _ in
			input.draw(
				in: CGRect(
					origin: .zero,
					size: targetSize
				)
			)
		}
	}
}
