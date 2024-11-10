//
//  OllamaModel.swift
//  Ollama
//
//  Created by Adolfo Vera Blasco on 7/11/24.
//

public struct Model: Sendable {
	public let namespace: String?
	public let name: String
	public let tag: String?
	
	public init(named name: String, withTag tag: String? = nil, namespace: String? = nil) {
		self.name = name
		self.tag = tag
		self.namespace = namespace
	}
}

extension Model: Equatable {
	public static func ==(lhs: Self, rhs: Self) -> Bool {
		if lhs.name == rhs.name {
			guard let lhsTag = lhs.tag, let rhsTag = rhs.tag else {
				return true
			}
			
			return lhsTag == rhsTag
		}
		
		return false
	}
}

extension Model: RawRepresentable {
	public typealias RawValue = String
	
	public var rawValue: String {
		let namespaceValue = namespace == nil ? "" : "\(namespace!)/"
		let tagValue = tag == nil ? "" : ":\(tag!)"
		
		return "\(namespaceValue)\(name)\(tagValue)"
	}
	
	public init?(rawValue: RawValue) {
		let components = rawValue.split(separator: "/", maxSplits: 1)

	   if components.count == 2 {
		   namespace = String(components[0])
		   
		   let modelAndTag = components[1].split(separator: ":", maxSplits: 1)
		   
		   name = String(modelAndTag[0])
		   tag = modelAndTag.count > 1 ? String(modelAndTag[1]) : nil
	   } else {
		   namespace = nil
		   
		   let modelAndTag = rawValue.split(separator: ":", maxSplits: 1)
		   
		   name = String(modelAndTag[0])
		   tag = modelAndTag.count > 1 ? String(modelAndTag[1]) : nil
	   }
	}
}

extension Model: Codable {
	public init(from decoder: Decoder) throws {
		let container = try decoder.singleValueContainer()
		let rawValue = try container.decode(String.self)
		
		guard let identifier = Model(rawValue: rawValue) else {
			throw DecodingError.dataCorruptedError(
				in: container, debugDescription: "Invalid Identifier string: \(rawValue)")
		}
		
		self = identifier
	}

	public func encode(to encoder: Encoder) throws {
		var container = encoder.singleValueContainer()
		try container.encode(rawValue)
	}
}

extension Model {
	static let llama32: Model = .init(rawValue: "llama3.2")!
}
