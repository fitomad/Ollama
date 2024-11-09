//
//  ChatCompletionRequestParameterBuilder.swift
//  Ollama
//
//  Created by Adolfo Vera Blasco on 7/11/24.
//

import Foundation

public final class ChatCompletionRequestBuilder {
	private var parameter = ChatCompletionRequest()
	private var messages = [ChatCompletionRequest.Message]()
	private var options: Options?
	
	public func withModel(_ model: OllamaModel) -> Self {
		parameter.model = model
		return self
	}
	
	public func withModel(named value: String) -> Self {
		return self
	}
	
	public func withMessage(_ content: String, as role: Role) -> Self {
		let message = ChatCompletionRequest.Message(role: role, content: content)
		messages.append(message)
		
		return self
	}
	
	public func withMessage(_ content: String, as role: Role, includingImages data: [Data]) -> Self {
		var message = ChatCompletionRequest.Message(role: role, content: content)
		message.base64EncodedImages = data.map { $0.base64EncodedString() }
		
		messages.append(message)
		
		return self
	}
	
	public func withFormat(_ format: Format) -> Self {
		parameter.format = format.rawValue
		
		return self
	}
	
	public func withFormat(_ format: String) throws -> Self {
		guard let validFormat = Format(rawValue: format) else {
			throw OllamaBuilderError.formatUnavailable
		}
		
		return withFormat(validFormat)
	}
	
	public func withStreamSupport(_ value: Bool) -> Self {
		parameter.isStream = value
		
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

extension ChatCompletionRequestBuilder: OllamaBuilder {
	public func build() throws(OllamaBuilderError) -> ChatCompletionRequest {
		parameter.messages = messages
		parameter.options = options
		
		guard parameter.model != nil else {
			throw .malformedParameter
		}
		
		return parameter
	}
}
