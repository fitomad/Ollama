//
//  LocalModelResponse.swift
//  Ollama
//
//  Created by Adolfo Vera Blasco on 8/11/24.
//

import Foundation

public struct LocalModelResponse: Decodable {
	public let models: [LocalModelResponse.Model]
	
	public var count: Int {
		models.count
	}
	
	public var isEmpty: Bool {
		models.isEmpty
	}
}

extension LocalModelResponse {
	public struct Model: Decodable {
		public struct Details: Decodable {
			public let format: String
			public let family: String
			public let parameterSize: String
			public let quantizationLevel: String
			
			private enum CodingKeys: String, CodingKey {
				case format
				case family
				case parameterSize = "parameter_size"
				case quantizationLevel = "quantization_level"
			}
		}
		
		public let name: String
		public let modifiedAt: Date
		public let size: Int
		public let digest: String
		public let details: Model.Details
		
		private enum CodingKeys: String, CodingKey {
			case name
			case modifiedAt = "modified_at"
			case size
			case digest
			case details
		}
	}
}
