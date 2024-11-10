//
//  Ollama+Completion.swift
//  Ollama
//
//  Created by Adolfo Vera Blasco on 8/11/24.
//

extension Ollama {
	private var completionEndpoint: String {
		return "\(settings.baseURL)/api/generate"
	}
	
	public func completion(parameter: CompletionRequest) async throws -> CompletionResponse {
		let response: CompletionResponse = try await performRequest(to: completionEndpoint,
																	payload: parameter,
																	httpMethod: .post)
		
		return response
	}
}
