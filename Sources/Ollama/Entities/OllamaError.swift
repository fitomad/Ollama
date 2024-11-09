//
//  OllamaError.swift
//  Ollama
//
//  Created by Adolfo Vera Blasco on 7/11/24.
//

import Foundation

public enum OllamaError: Error {
	case invalidURL(string: String)
	case invalidParameter
	case invalidResponse(message: String)
	case invalidData
}
