//
//  ImagePipeline.swift
//  ImagePipelineLab
//
//  Created by arcade on 01/08/26.
//

import Foundation

struct ImagePipeline<
	Loader: ImageDataLoading,
	Processor: ImageProcessing
> where Processor.Input == Data {

	private let loader: Loader
	private let processor: Processor

	init(loader: Loader, processor: Processor) {
		self.loader = loader
		self.processor = processor
	}

	func load(from source: Loader.Source) async throws -> Processor.Output {
		let data = try await loader.load(from: source)
		return try processor.process(data)
	}
}
