//
//  Ollama+RunningModel.swift
//  Ollama
//
//  Created by Adolfo Vera Blasco on 8/11/24.
//

extension Ollama {
	fileprivate var runningModelEndpoint: String {
		return "\(settings.baseURL)/api/ps"
	}
	
	public func runningModels() async throws -> RunningModelResponse {
		let response: RunningModelResponse = try await performRequest(to: runningModelEndpoint)
		
		return response
	}
}
