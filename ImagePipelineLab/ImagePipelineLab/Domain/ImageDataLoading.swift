//
//  ImageDataLoading.swift
//  ImagePipelineLab
//
//  Created by arcade on 01/08/26.
//

import Foundation

protocol ImageDataLoading: Sendable {
	associatedtype Source: Hashable & Sendable

	func load(from source: Source) async throws -> Data
}
