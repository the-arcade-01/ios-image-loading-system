//
//  IdentityProcessor.swift
//  ImagePipelineLab
//
//  Created by arcade on 01/08/26.
//

import Foundation

struct IdentityProcessor<Value>: ImageProcessing {
	func process(_ input: Value) throws -> Value {
		input
	}
}
