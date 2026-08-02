//
//  ImageLoadingPhase.swift
//  ImagePipelineLab
//
//  Created by arcade on 01/08/26.
//

import SwiftUI

enum ImageLoadingPhase {
	case idle
	case loading
	case success(UIImage)
	case failure(Error)
}
