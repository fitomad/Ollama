//
//  CompletionRequestParameter.swift
//  Ollama
//
//  Created by Adolfo Vera Blasco on 7/11/24.
//

public struct CompletionRequest: Encodable {
	var model: Model?
	var prompt: String?
	var suffix: String?
	var base64Images: [String]?
	
	var format: Format?
	var systemMessage: String?
	var template: String?
	var context: String?
	var isStream = false
	var isRaw: Bool?
	var keepAlive: String?
	var options: Options?
	
	enum CodingKeys: String, CodingKey {
		case model
		case prompt
		case suffix
		case base64Images = "images"
		case format
		case systemMessage = "system"
		case template
		case context
		case isStream = "stream"
		case isRaw = "raw"
		case keepAlive = "keep_alive"
		case options
	}
}
