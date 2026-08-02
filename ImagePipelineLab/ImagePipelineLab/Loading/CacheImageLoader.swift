//
//  CacheImageLoader.swift
//  ImagePipelineLab
//
//  Created by arcade on 01/08/26.
//

import Foundation

struct CacheImageLoader<Upstream: ImageDataLoading>: ImageDataLoading {
	typealias Source = Upstream.Source

	private let upstream: Upstream
	private let cache: ImageDataCache<Source>

	init(
		upstream: Upstream,
		cache: ImageDataCache<Source> = ImageDataCache()
	) {
		self.upstream = upstream
		self.cache = cache
	}

	func load(from source: Upstream.Source) async throws -> Data {
		if let cachedData = await cache.value(for: source) {
			return cachedData
		}

		let data = try await upstream.load(from: source)
		await cache.insert(data, for: source)

		return data
	}
}
