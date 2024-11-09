// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

public final class Ollama: Sendable {
	private let urlSession: URLSession
	private let jsonEncoder: JSONEncoder
	private let jsonDecoder: JSONDecoder
	public let settings: Ollama.Settings
	
	public convenience init() {
		let defaultSettings = Ollama.Settings(baseURL: Constants.baseURL)
		self.init(settings: defaultSettings)
	}
	
	public init(settings: Ollama.Settings) {
		self.settings = settings
		
		let urlSessionConfiguration = URLSessionConfiguration.ephemeral
		urlSession = URLSession(configuration: urlSessionConfiguration)
		
		jsonEncoder = JSONEncoder()
		
		jsonDecoder = JSONDecoder()
		jsonDecoder.dateDecodingStrategy = .custom(decodeDate)
	}
	
	func performRequest<Output: Decodable>(to endpoint: String, payload: (any Encodable)? = nil, httpMethod: String = "GET") async throws(OllamaError) -> Output {
		guard let endpointURL = URL(string: endpoint) else {
			throw .invalidURL(string: endpoint)
		}
		
		var ollamaRequest = URLRequest(url: endpointURL)
		ollamaRequest.httpMethod = httpMethod
		
		if let payload {
			do {
				let body = try jsonEncoder.encode(payload)
				ollamaRequest.httpBody = body
			} catch {
				throw .invalidParameter
			}
		}
		
		do {
			let (data, urlResponse) = try await urlSession.data(for: ollamaRequest)
			
			guard let httpResponse = urlResponse as? HTTPURLResponse,
				  httpResponse.statusCode == 200
			else
			{
				throw OllamaError.invalidResponse(message: "Non valid HTTP response")
			}
			
			let output = try jsonDecoder.decode(Output.self, from: data)
			return output
		} catch let error {
			debugPrint(error)
			throw .invalidResponse(message: error.localizedDescription)
		}
	}
	
	private func decodeDate(from decoder: Decoder) throws -> Date {
		let container = try decoder.singleValueContainer()
		let dateString = try container.decode(String.self)
		
		let formatter = ISO8601DateFormatter()
		formatter.formatOptions = [ .withInternetDateTime, .withFractionalSeconds ]
		
		if let date = formatter.date(from: dateString) {
			return date
		}
		
		formatter.formatOptions = [.withInternetDateTime]
		
		if let date = formatter.date(from: dateString) {
			return date
		}
		
		throw DecodingError.dataCorruptedError(in: container, debugDescription: "Could not decode date from string: \(dateString)")
	}
}

extension Ollama {
	enum Constants {
		static let baseURL = "http://localhost:11434"
	}
	
	public struct Settings: Sendable {
		let baseURL: String
	}
}
