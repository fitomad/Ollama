//
//  OllamaModel.swift
//  Ollama
//
//  Created by Adolfo Vera Blasco on 7/11/24.
//

public enum OllamaModel: String, Codable {
	case llama32Vision = "llama3.2-vision"
	case llama32 = "llama3.2"
	case llama31 = "llama3.1"
	case deepseekCoderV2 = "deepseek-coder-v2"
}

extension OllamaModel: Sendable {}
extension OllamaModel: CaseIterable {}
