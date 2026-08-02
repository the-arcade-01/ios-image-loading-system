//
//  NetworkImageLoader.swift
//  ImagePipelineLab
//
//  Created by arcade on 01/08/26.
//

import Foundation

struct NetworkImageLoader: ImageDataLoading {
	typealias Source = URL

	private let session: URLSession

	init(session: URLSession = .shared) {
		self.session = session
	}

	func load(from source: URL) async throws -> Data {
		let (data, response) = try await session.data(from: source)

		guard let httpResponse = response as? HTTPURLResponse else {
			throw ImageLoadingError.invalidResponse
		}

		guard (200...299).contains(httpResponse.statusCode) else {
			throw ImageLoadingError.unsuccessfulStatusCode(httpResponse.statusCode)
		}

		guard !data.isEmpty else {
			throw ImageLoadingError.emptyData
		}

		return data
	}
}
