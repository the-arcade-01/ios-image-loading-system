//
//  ImageDataCache.swift
//  ImagePipelineLab
//
//  Created by arcade on 01/08/26.
//

import Foundation

actor ImageDataCache<Key: Hashable & Sendable> {
	private var storage: [Key: Data] = [:]

	func value(for key: Key) -> Data? {
		storage[key]
	}

	func insert(_ data: Data, for key: Key) {
		storage[key] = data
	}

	func removeValue(for key: Key) {
		storage.removeValue(forKey: key)
	}

	func removeAll() {
		storage.removeAll()
	}

	var count: Int {
		storage.count
	}
}
