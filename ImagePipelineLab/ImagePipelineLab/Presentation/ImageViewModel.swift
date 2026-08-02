//
//  ImageViewModel.swift
//  ImagePipelineLab
//
//  Created by arcade on 01/08/26.
//

import Foundation
import SwiftUI

@Observable
final class ImageViewModel<
	Loader: ImageDataLoading,
	Processor: ImageProcessing
>
where
	Processor.Input == Data,
	Processor.Output == UIImage
{
	private(set) var phase: ImageLoadingPhase = .idle

	private let source: Loader.Source
	private let pipeline: ImagePipeline<Loader, Processor>

	init(source: Loader.Source, pipeline: ImagePipeline<Loader, Processor>) {
		self.source = source
		self.pipeline = pipeline
	}

	func load() async {
		guard case .idle = phase else {
			return
		}

		phase = .loading

		do {
			let image = try await pipeline.load(from: source)
			try Task.checkCancellation()
			phase = .success(image)
		} catch is CancellationError {
			phase = .idle
		} catch {
			phase = .failure(error)
		}
	}

	func retry() async {
		phase = .idle
		await load()
	}
}
