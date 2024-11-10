//
//  CompletionRequestBuilderTests.swift
//  Ollama
//
//  Created by Adolfo Vera Blasco on 8/11/24.
//

import Testing
@testable import Ollama

@Test("Completion. Model", .tags(.completion), arguments: [ Model.llama32 ])
func testCompletionRequestBuilderModel(model: Model) async throws {
	#expect(throws: OllamaBuilderError.malformedParameter) {
		let parameter = try CompletionRequestBuilder()
			.withModel(model)
			.build()
		
		#expect(parameter.model == model, "Expected \(model.rawValue)* model")
	}
}

@Test("Completion. Format", .tags(.completion))
func testCompletionRequestBuilderFormat() async throws {
	#expect(throws: OllamaBuilderError.malformedParameter) {
		let parameter = try CompletionRequestBuilder()
			.withFormat(.json)
			.build()
		
		#expect(parameter.format == .json, "Expected *.json* format")
	}
}

@Test("Completion. If SYSTEM setted Raw must be set to false", .tags(.completion))
func testCompletionRequestBuilderSystemRawTrue() async throws {
	#expect(throws: OllamaBuilderError.malformedParameter) {
		let _ = try CompletionRequestBuilder()
			.withModel(.llama32)
			.withPrompt("Tell me something about Spain")
			.withSystemMessage("You are a travel agency worker expert in Spain")
			.withRawSupport(true)
			.build()
	}
}

@Test("Completion. If SYSTEM setted Raw must be set to false", .tags(.completion))
func testCompletionRequestBuilderSystemRawFalse() async throws {
	let _ = try CompletionRequestBuilder()
		.withModel(.llama32)
		.withPrompt("Tell me something about Spain")
		.withSystemMessage("You are a travel agency worker expert in Spain")
		.withRawSupport(false)
		.build()
}

@Test("Completion. Model+Prompt", .tags(.completion), arguments: [ Model.llama32 ])
func testCompletionRequestBuilderPrompt(model: Model) async throws {
	let parameter = try CompletionRequestBuilder()
		.withModel(model)
		.withPrompt("Where is Spain?")
		.build()
	
	#expect(parameter.model == model, "Expected \(model.rawValue)* model")
	#expect(parameter.prompt?.isEmpty == false)
}

@Test("Completion. Model+Prompt+Images", .tags(.completion), arguments: [ Model.llama32 ])
func testCompletionRequestBuilderImages(model: Model) async throws {
	guard let fraguaDeVulcano = "Fragua de Vulcano, de Diego Velázquez".data(using: .utf8) else {
		return
	}
	
	let encodedFraguaDeVulcano = fraguaDeVulcano.base64EncodedString()
	
	let parameter = try CompletionRequestBuilder()
		.withModel(model)
		.withPrompt("Where is Spain?")
		.withImage(data: fraguaDeVulcano)
		.build()
	
	#expect(parameter.model == model, "Expected \(model.rawValue)* model")
	#expect(parameter.prompt?.isEmpty == false)
	#expect(parameter.base64Images?.first == encodedFraguaDeVulcano)
}

@Test("Completion. Model+Prompt+Images+Context", .tags(.completion), arguments: [ Model.llama32 ])
func testCompletionRequestBuilderContext(model: Model) async throws {
	guard let fraguaDeVulcano = "Fragua de Vulcano, de Diego Velázquez".data(using: .utf8) else {
		return
	}
	
	let encodedFraguaDeVulcano = fraguaDeVulcano.base64EncodedString()
	
	let parameter = try CompletionRequestBuilder()
		.withModel(model)
		.withPrompt("Where is Spain?")
		.withImage(data: fraguaDeVulcano)
		.withContext("Previusly we talk about live")
		.build()
	
	#expect(parameter.model == model, "Expected \(model.rawValue)* model")
	#expect(parameter.prompt?.isEmpty == false)
	#expect(parameter.base64Images?.first == encodedFraguaDeVulcano)
	#expect(parameter.context?.isEmpty == false)
}

@Test("Completion. Model+Prompt+Images+Context+System", .tags(.completion), arguments: [ Model.llama32 ])
func testCompletionRequestBuilderSystem(model: Model) async throws {
	guard let fraguaDeVulcano = "Fragua de Vulcano, de Diego Velázquez".data(using: .utf8) else {
		return
	}
	
	let encodedFraguaDeVulcano = fraguaDeVulcano.base64EncodedString()
	
	let parameter = try CompletionRequestBuilder()
		.withModel(model)
		.withPrompt("Where is Spain?")
		.withImage(data: fraguaDeVulcano)
		.withContext("Previusly we talk about live")
		.withSystemMessage("You are a senior Swift developer")
		.build()
	
	#expect(parameter.model == model, "Expected \(model.rawValue)* model")
	#expect(parameter.prompt?.isEmpty == false)
	#expect(parameter.base64Images?.first == encodedFraguaDeVulcano)
	#expect(parameter.context?.isEmpty == false)
	#expect(parameter.systemMessage?.isEmpty == false)
}

@Test("Completion. Model+Prompt+Images+Context+System+Template", .tags(.completion), arguments: [ Model.llama32 ])
func testCompletionRequestBuilderTemplate(model: Model) async throws {
	guard let fraguaDeVulcano = "Fragua de Vulcano, de Diego Velázquez".data(using: .utf8) else {
		return
	}
	
	let encodedFraguaDeVulcano = fraguaDeVulcano.base64EncodedString()
	
	let parameter = try CompletionRequestBuilder()
		.withModel(model)
		.withPrompt("Where is Spain?")
		.withImage(data: fraguaDeVulcano)
		.withContext("Previusly we talk about live")
		.withSystemMessage("You are a senior Swift developer")
		.withTemplate("This is a template for {me}")
		.build()
	
	#expect(parameter.model == model, "Expected \(model.rawValue)* model")
	#expect(parameter.prompt?.isEmpty == false)
	#expect(parameter.base64Images?.first == encodedFraguaDeVulcano)
	#expect(parameter.context?.isEmpty == false)
	#expect(parameter.systemMessage?.isEmpty == false)
	#expect(parameter.template?.isEmpty == false)
}

@Test("Completion. Model+Prompt+Images+Context+System+Template+Sufix", .tags(.completion), arguments: [ Model.llama32 ])
func testCompletionRequestBuilderSyfix(model: Model) async throws {
	guard let fraguaDeVulcano = "Fragua de Vulcano, de Diego Velázquez".data(using: .utf8) else {
		return
	}
	
	let encodedFraguaDeVulcano = fraguaDeVulcano.base64EncodedString()
	
	let parameter = try CompletionRequestBuilder()
		.withModel(model)
		.withPrompt("Where is Spain?")
		.withImage(data: fraguaDeVulcano)
		.withContext("Previusly we talk about live")
		.withSystemMessage("You are a senior Swift developer")
		.withTemplate("This is a template for {me}")
		.withSuffix(" and say good bye!")
		.build()
	
	#expect(parameter.model == model, "Expected \(model.rawValue)* model")
	#expect(parameter.prompt?.isEmpty == false)
	#expect(parameter.base64Images?.first == encodedFraguaDeVulcano)
	#expect(parameter.context?.isEmpty == false)
	#expect(parameter.systemMessage?.isEmpty == false)
	#expect(parameter.template?.isEmpty == false)
	#expect(parameter.suffix?.isEmpty == false)
}

@Test("Completion. All", .tags(.completion), arguments: [ Model.llama32 ])
func testCompletionRequestBuilderAll(model: Model) async throws {
	guard let fraguaDeVulcano = "Fragua de Vulcano, de Diego Velázquez".data(using: .utf8) else {
		return
	}
	
	let encodedFraguaDeVulcano = fraguaDeVulcano.base64EncodedString()
	
	let parameter = try CompletionRequestBuilder()
		.withModel(model)
		.withPrompt("Where is Spain?")
		.withImage(data: fraguaDeVulcano)
		.withContext("Previusly we talk about live")
		.withSystemMessage("You are a senior Swift developer")
		.withTemplate("This is a template for {me}")
		.withSuffix(" and say good bye!")
		.withStreamSupport(false)
		.withRawSupport(false)
		.withModelSeed(750)
		.withModelTemperature(2.0)
		.withKeepAlive("Always on")
		.build()
	
	#expect(parameter.model == model, "Expected \(model.rawValue)* model")
	#expect(parameter.prompt?.isEmpty == false)
	#expect(parameter.base64Images?.first == encodedFraguaDeVulcano)
	#expect(parameter.context?.isEmpty == false)
	#expect(parameter.systemMessage?.isEmpty == false)
	#expect(parameter.template?.isEmpty == false)
	#expect(parameter.suffix?.isEmpty == false)
	#expect(parameter.isStream == false)
	#expect(parameter.isRaw == .some(false))
	#expect(parameter.options?.seed == 750)
	#expect(parameter.options?.temperature == 2.0)
	#expect(parameter.keepAlive == "Always on")
}

extension Tag {
	@Tag static var completion: Tag
}
