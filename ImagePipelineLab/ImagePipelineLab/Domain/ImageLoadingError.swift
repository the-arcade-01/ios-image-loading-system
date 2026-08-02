//
//  ImageLoadingError.swift
//  ImagePipelineLab
//
//  Created by arcade on 01/08/26.
//

import Foundation

enum ImageLoadingError: Error, LocalizedError {
	case invalidResponse
	case unsuccessfulStatusCode(Int)
	case emptyData
	case decodingFailed
	case localResourceNotFound(String)

	var errorDescription: String? {
		switch self {
		case .invalidResponse:
			return "Invalid Response returned by server"
		case .unsuccessfulStatusCode(let code):
			return "Server return HTTP status code \(code)"
		case .emptyData:
			return "No image data was returned"
		case .decodingFailed:
			return "Downloaded data could not be decoded as an image"
		case .localResourceNotFound(let name):
			return "Local resource \(name) not found"
		}
	}
}
