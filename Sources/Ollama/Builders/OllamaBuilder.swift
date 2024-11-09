//
//  OllamaBuilder.swift
//  Ollama
//
//  Created by Adolfo Vera Blasco on 7/11/24.
//

import Foundation

public protocol OllamaBuilder {
	associatedtype Output
	
	func build() throws(OllamaBuilderError) -> Output
}
