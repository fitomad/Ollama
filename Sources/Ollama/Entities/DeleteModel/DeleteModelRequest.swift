//
//  DeleteModelRequest.swift
//  Ollama
//
//  Created by Adolfo Vera Blasco on 10/11/24.
//

public struct DeleteModelRequest: Encodable {
	public internal(set) var model: Model?
	
	private enum CodingKeys: String, CodingKey {
		case model = "name"
	}
}
