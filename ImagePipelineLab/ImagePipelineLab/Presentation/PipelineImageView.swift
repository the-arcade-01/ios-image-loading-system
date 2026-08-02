//
//  PipelineImageView.swift
//  ImagePipelineLab
//
//  Created by arcade on 01/08/26.
//

import SwiftUI

struct PipelineImageView<
	Loader: ImageDataLoading,
	Processor: ImageProcessing
>: View
where Processor.Input == Data, Processor.Output == UIImage {

	@State private var viewModel: ImageViewModel<Loader, Processor>

	init(source: Loader.Source, pipeline: ImagePipeline<Loader, Processor>) {
		_viewModel = State(
			initialValue: ImageViewModel(source: source, pipeline: pipeline)
		)
	}

	var body: some View {
		content
			.task {
				await viewModel.load()
			}
	}

	@ViewBuilder
	private var content: some View {
		switch viewModel.phase {
		case .idle, .loading:
			ProgressView()
				.frame(maxWidth: .infinity, minHeight: 200)
		case .success(let image):
			Image(uiImage: image)
				.resizable()
				.scaledToFill()
				.frame(height: 200)
				.clipped()
		case .failure(let error):
			ContentUnavailableView {
				Label(
					"Unable to Load Image",
					systemImage: "photo.badge.exclamationmark"
				)
			} description: {
				Text(error.localizedDescription)
			} actions: {
				Button("Retry") {
					Task {
						await viewModel.retry()
					}
				}
			}
		}
	}
}
