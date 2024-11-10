//
//  OllamaBuilderError.swift
//  Ollama
//
//  Created by Adolfo Vera Blasco on 7/11/24.
//

import Foundation

public enum OllamaBuilderError: Error {
	case malformedParameter
	case nonValidModelFormat
	case formatUnavailable
}
