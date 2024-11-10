//
//  DeleteModelRequestBuilder.swift
//  Ollama
//
//  Created by Adolfo Vera Blasco on 10/11/24.
//

import Foundation

public final class DeleteModelRequestBuilder {
	private var parameter = DeleteModelRequest()
	
	public func withModel(_ model: Model) -> Self {
		parameter.model = model
		
		return self
	}
	
	public func withModel(named value: String) throws -> Self {
		guard let model = Model(rawValue: value) else {
			throw OllamaBuilderError.nonValidModelFormat
		}
		
		parameter.model = model
		
		return self
	}
}

extension DeleteModelRequestBuilder: OllamaBuilder {
	public func build() throws(OllamaBuilderError) -> DeleteModelRequest {
		if parameter.model == nil {
			throw OllamaBuilderError.malformedParameter
		}
		
		return parameter
	}
}
