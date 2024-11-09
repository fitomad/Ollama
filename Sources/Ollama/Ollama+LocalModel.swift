//
//  Ollama+LocalModel.swift
//  Ollama
//
//  Created by Adolfo Vera Blasco on 8/11/24.
//

extension Ollama {
	fileprivate var localModelEndpoint: String {
		return "\(settings.baseURL)/api/tags"
	}
	
	public func localModels() async throws -> LocalModelResponse {
		let response: LocalModelResponse = try await performRequest(to: localModelEndpoint)
		
		return response
	}
}
