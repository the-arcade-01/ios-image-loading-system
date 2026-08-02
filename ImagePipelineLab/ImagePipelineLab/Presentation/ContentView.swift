//
//  ContentView.swift
//  ImagePipelineLab
//
//  Created by arcade on 01/08/26.
//

import SwiftUI

struct ContentView: View {
	private let urls: [URL] = [
		URL(string: "https://picsum.photos/id/10/800/600")!,
		URL(string: "https://picsum.photos/id/20/800/600")!,
		URL(string: "https://picsum.photos/id/30/800/600")!,
	]

	private let pipeline = ImagePipeline(
		loader: CacheImageLoader(upstream: NetworkImageLoader()),
		processor: ProcessorPipeline(
			first: ImageDecoder(),
			second: ResizeProcessor(targetSize: CGSize(width: 600, height: 400))
		)
	)

	var body: some View {
		NavigationStack {
			ScrollView {
				LazyVStack(spacing: 16) {
					ForEach(urls, id: \.self) { url in
						PipelineImageView(source: url, pipeline: pipeline)
							.clipShape(RoundedRectangle(cornerRadius: 16))
					}
				}
				.padding()
			}
			.navigationTitle("Image Pipeline")
		}
	}
}
