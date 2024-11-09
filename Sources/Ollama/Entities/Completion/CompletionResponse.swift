//
//  CompletionResponse.swift
//  Ollama
//
//  Created by Adolfo Vera Blasco on 7/11/24.
//

import Foundation

public struct CompletionResponse: Decodable {
	public let model: OllamaModel
	public let createdAt: Date
	public let response: String
	public let isDone: Bool
	public let context: [Int]?
	public let totalDuration: Int?
	public let loadDuration: Int?
	public let promptEvaluationCount: Int?
	public let promptEvaluationDuration: Int?
	public let evaluationCount: Int?
	public let evaluationDuration: Int?
	
	enum CodingKeys: String, CodingKey {
		case model
		case createdAt = "created_at"
		case response
		case isDone = "done"
		case context
		case totalDuration = "total_duration"
		case loadDuration = "load_duration"
		case promptEvaluationCount = "prompt_eval_count"
		case promptEvaluationDuration = "prompt_eval_duration"
		case evaluationCount = "eval_count"
		case evaluationDuration = "eval_duration"
	}
}
