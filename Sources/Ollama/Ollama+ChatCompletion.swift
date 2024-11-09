//
//  Ollama+ChatCompletion.swift
//  Ollama
//
//  Created by Adolfo Vera Blasco on 7/11/24.
//

extension Ollama {
	fileprivate var chatCompletionEndpoint: String {
		return "\(settings.baseURL)/api/chat"
	}
	
	public func chatCompletion(parameter: ChatCompletionRequest) async throws -> ChatCompletionResponse {
		let response: ChatCompletionResponse = try await performRequest(to: chatCompletionEndpoint,
																		payload: parameter,
																		httpMethod: "POST")
		
		return response
	}
}
