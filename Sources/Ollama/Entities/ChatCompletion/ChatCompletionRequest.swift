//
//  ChatCompletionRequestParameter.swift
//  Ollama
//
//  Created by Adolfo Vera Blasco on 7/11/24.
//

public struct ChatCompletionRequest: Encodable {
	var model: Model?
	var messages: [ChatCompletionRequest.Message]?
	var options: Options?
	
	var format: String?
	var isStream = false
	var keepAlive: String?
	
	enum CodingKeys: String, CodingKey {
		case model
		case messages
		case format
		case options
		case isStream = "stream"
		case keepAlive = "keep_alive"
	}
}

extension ChatCompletionRequest {
	public struct Message: Encodable {
		var role: Role
		var content: String
		var base64EncodedImages: [String]?
		
		enum CodingKeys: String, CodingKey {
			case role
			case content
			case base64EncodedImages = "images"
		}
	}
}
