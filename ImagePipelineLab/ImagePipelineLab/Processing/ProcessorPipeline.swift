//
//  ProcessorPipeline.swift
//  ImagePipelineLab
//
//  Created by arcade on 01/08/26.
//

import Foundation

struct ProcessorPipeline<
	First: ImageProcessing,
	Second: ImageProcessing
>:
	ImageProcessing
where First.Output == Second.Input {
	private let first: First
	private let second: Second

	init(first: First, second: Second) {
		self.first = first
		self.second = second
	}

	func process(_ input: First.Input) throws -> Second.Output {
		let intermediateValue = try first.process(input)
		return try second.process(intermediateValue)
	}
}
