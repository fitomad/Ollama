//
//  RunningModelResponse.swift
//  Ollama
//
//  Created by Adolfo Vera Blasco on 8/11/24.
//

import Foundation

public struct RunningModelResponse: Decodable {
	public let models: [RunningModelResponse.Model]
	
	public var count: Int {
		models.count
	}
	
	public var isEmpty: Bool {
		models.isEmpty
	}
}

extension RunningModelResponse {
	public struct Model: Decodable {
		public struct Details: Decodable {
			public let parentModel: String
			public let format: String
			public let family: String
			public let parameterSize: String
			public let quantizationLevel: String
			public let modelFamilies: [String]
			
			private enum CodingKeys: String, CodingKey {
				case parentModel = "parent_model"
				case format
				case family
				case parameterSize = "parameter_size"
				case quantizationLevel = "quantization_level"
				case modelFamilies = "families"
			}
		}
		
		public let name: String
		public let model: String
		public let size: Int
		public let digest: String
		public let expiresAt: Date
		public let sizeVirtualRAM: Int
		public let details: Model.Details
		
		private enum CodingKeys: String, CodingKey {
			case name
			case model
			case size
			case digest
			case expiresAt = "expires_at"
			case sizeVirtualRAM = "size_vram"
			case details
		}
	}
}
