//
//  Ollama+DeleteModel.swift
//  Ollama
//
//  Created by Adolfo Vera Blasco on 10/11/24.
//

import Foundation

extension Ollama {
	fileprivate var deleteModelEndpoint: String {
		"\(settings.baseURL)/api/delete"
	}
	
	public func deleteModel(parameter: DeleteModelRequest) async throws -> OllamaResponse {
		let response: OllamaResponse = try await performRequest(to: deleteModelEndpoint,
																payload: parameter,
																httpMethod: .delete)
		
		return response
	}
}
