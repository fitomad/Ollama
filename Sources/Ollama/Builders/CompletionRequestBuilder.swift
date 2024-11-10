//
//  CompletionParameterBuilder.swift
//  Ollama
//
//  Created by Adolfo Vera Blasco on 8/11/24.
//

import Foundation

public final class CompletionRequestBuilder {
	private var parameter = CompletionRequest()
	private var options: Options?
	
	private var isRawPropertySetted = false
	
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
	
	public func withPrompt(_ content: String) -> Self {
		parameter.prompt = content
		
		return self
	}
	
	public func withFormat(_ format: Format) -> Self {
		parameter.format = format
		
		return self
	}
	
	public func withFormat(_ format: String) throws -> Self {
		guard let validFormat = Format(rawValue: format) else {
			throw OllamaBuilderError.formatUnavailable
		}
		
		return withFormat(validFormat)
	}
	
	public func withSuffix(_ content: String) -> Self {
		parameter.suffix = content
		
		return self
	}
	
	public func withImage(data: Data) -> Self {
		return withImageList(data: [ data ])
	}
	
	public func withImageList(data: [Data]) -> Self {
		if parameter.base64Images == nil {
			parameter.base64Images = [String]()
		}
		
		let encodedImages = data.map { $0.base64EncodedString() }
		parameter.base64Images?.append(contentsOf: encodedImages)
		
		return self
	}
	
	public func withSystemMessage(_ content: String) -> Self {
		parameter.systemMessage = content
		
		return self
	}
	
	public func withTemplate(_ content: String) -> Self {
		parameter.template = content
		
		return self
	}
	
	public func withContext(_ content: String) -> Self {
		parameter.context = content
		
		return self
	}
	
	public func withStreamSupport(_ value: Bool) -> Self {
		parameter.isStream = value
		
		return self
	}
	
	public func withRawSupport(_ value: Bool) -> Self {
		parameter.isRaw = value
		isRawPropertySetted = true
		
		return self
	}
	
	public func withKeepAlive(_ value: String) -> Self {
		parameter.keepAlive = value
		
		return self
	}
	
	public func withModelSeed(_ seed: Int) -> Self {
		if options == nil {
			options = .init()
		}
		
		options?.seed = seed
		
		return self
	}
	
	public func withModelTemperature(_ temperature: Double) -> Self {
		if options == nil {
			options = .init()
		}
		
		options?.temperature = temperature
		
		return self
	}
}

extension CompletionRequestBuilder: OllamaBuilder {
	public func build() throws(OllamaBuilderError) -> CompletionRequest {
		parameter.options = options
		
		guard parameter.model != nil else {
			throw .malformedParameter
		}
		
		guard parameter.prompt != nil else {
			throw .malformedParameter
		}
		
		if (parameter.systemMessage != nil) && (isRawPropertySetted) {
			if let isRaw = parameter.isRaw, isRaw {
				throw .malformedParameter
			}
		}
		
		return parameter
	}
}
