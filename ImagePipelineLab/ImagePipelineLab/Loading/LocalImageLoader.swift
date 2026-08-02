//
//  LocalImageLoader.swift
//  ImagePipelineLab
//
//  Created by arcade on 01/08/26.
//

import Foundation

nonisolated struct LocalImageSource: Hashable, Sendable {
	let name: String
	let fileExtension: String

	init(name: String, fileExtension: String) {
		self.name = name
		self.fileExtension = fileExtension
	}
}

nonisolated struct LocalImageLoader: ImageDataLoading {
	typealias Source = LocalImageSource

	private let bundle: Bundle

	init(bundle: Bundle = .main) {
		self.bundle = bundle
	}

	@concurrent func load(from source: LocalImageSource) async throws -> Data {
		guard
			let url = bundle.url(
				forResource: source.name,
				withExtension: source.fileExtension
			)
		else {
			throw ImageLoadingError.localResourceNotFound(source.name)
		}

		let data = try Data(contentsOf: url)

		guard !data.isEmpty else {
			throw ImageLoadingError.emptyData
		}
		return data
	}
}
