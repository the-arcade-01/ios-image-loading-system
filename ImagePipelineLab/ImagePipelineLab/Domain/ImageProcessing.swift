//
//  ImageProcessing.swift
//  ImagePipelineLab
//
//  Created by arcade on 01/08/26.
//

import Foundation

protocol ImageProcessing {
	associatedtype Input
	associatedtype Output

	func process(_ input: Input) throws -> Output
}
