import Testing
@testable import Ollama

@Test("Check supported models" , .tags(.chatCompletion), arguments: OllamaModel.allCases)
func testChatCompletionParameterBuilderModels(model: OllamaModel) {
	#expect(throws: Never.self) {
		let parameter = try ChatCompletionRequestBuilder()
			.withModel(model)
			.build()
		
		#expect(parameter.model == model, "Expected \(model.rawValue)* model")
	}
		
}

@Test("Throw error cause we don't set the Model", .tags(.chatCompletion))
func testChatCompletionParameterBuilderError() {
	#expect(throws: OllamaBuilderError.self) {
		let _ = try ChatCompletionRequestBuilder()
			.build()
	}
		
}

@Test("Messages OK", .tags(.chatCompletion))
func testChatCompletionParameterBuilderWithMessages() {
	#expect(throws: Never.self) {
		let parameter = try ChatCompletionRequestBuilder()
			.withModel(.llama32)
			.withMessage("You are a senior Swift on server developer", as: .system)
			.withMessage("Could you please tell me the current available swift on server frameworks?", as: .user)
			.build()
		
		#expect(parameter.messages != nil, "Messages has been set")
		#expect(parameter.messages?.count == 2, "Expected 2 messages")
	}
}

@Test("Options OK", .tags(.chatCompletion))
func testChatCompletionParameterBuilderWithOptions() {
	#expect(throws: Never.self) {
		let parameter = try ChatCompletionRequestBuilder()
			.withModel(.llama32)
			.withModelSeed(50)
			.withModelTemperature(0.1)
			.build()
		
		#expect(parameter.options != nil, "Messages has been set")
		#expect(parameter.options?.seed == 50, "Seed value setted to 50")
		#expect(parameter.options?.temperature == 0.1, "Temperature value setted to 0.1")
	}
}

@Test("Messages & Options OK", .tags(.chatCompletion))
func testChatCompletionParameterBuilderWithMessageAndOptions() {
	#expect(throws: Never.self) {
		let parameter = try ChatCompletionRequestBuilder()
			.withModel(.llama32)
			.withMessage("You are a senior Swift on server developer", as: .system)
			.withMessage("Could you please tell me the current available swift on server frameworks?", as: .user)
			.withModelSeed(50)
			.withModelTemperature(0.1)
			.build()
		
		#expect(parameter.options != nil, "Messages has been set")
		#expect(parameter.options?.seed == 50, "Seed value setted to 50")
		#expect(parameter.options?.temperature == 0.1, "Temperature value setted to 0.1")
		
		#expect(parameter.messages != nil, "Messages has been set")
		#expect(parameter.messages?.count == 2, "Expected 2 messages")
	}
}

@Test("Format using the `Format` enum", .tags(.chatCompletion))
func testChatCompletionParameterBuilderFormat() {
	#expect(throws: Never.self) {
		let parameter = try ChatCompletionRequestBuilder()
			.withModel(.llama32)
			.withFormat(Format.json)
			.build()
		
		#expect(parameter.format == "json")
	}
}

@Test("Format using a custom string value", .tags(.chatCompletion))
func testChatCompletionParameterBuilderFormatUsingString() {
	#expect(throws: Never.self) {
		let parameter = try ChatCompletionRequestBuilder()
			.withModel(.llama32)
			.withFormat("json")
			.build()
		
		#expect(parameter.format == "json")
	}
}

@Test("Format failure cause string value is not valid", .tags(.chatCompletion))
func testChatCompletionParameterBuilderFormatFailure() {
	#expect(throws: OllamaBuilderError.formatUnavailable) {
		let _ = try ChatCompletionRequestBuilder()
			.withModel(.llama32)
			.withFormat("csv")
			.build()
	}
}

@Test("KeepAlive OK", .tags(.chatCompletion))
func testChatCompletionParameterBuilderKeepAlive() {
	#expect(throws: Never.self) {
		let parameter = try ChatCompletionRequestBuilder()
			.withModel(.llama32)
			.withKeepAlive("10ms")
			.build()
		
		#expect(parameter.keepAlive == "10ms")
	}
}

@Test("Stream set to `true`", .tags(.chatCompletion))
func testChatCompletionParameterBuilderStreamEnable() {
	#expect(throws: Never.self) {
		let parameter = try ChatCompletionRequestBuilder()
			.withModel(.llama32)
			.withStreamSupport(true)
			.build()
		
		#expect(parameter.isStream)
	}
}

@Test("Stream set to `false`", .tags(.chatCompletion))
func testChatCompletionParameterBuilderStreamDisable() {
	#expect(throws: Never.self) {
		let parameter = try ChatCompletionRequestBuilder()
			.withModel(.llama32)
			.withStreamSupport(false)
			.build()
		
		#expect(parameter.isStream ==  false)
	}
}

@Test("Message Images OK", .tags(.chatCompletion))
func testChatCompletionParameterBuilderImages() {
	guard let fraguaDeVulcano = "Fragua de Vulcano, de Diego Velázquez".data(using: .utf8) else {
		return
	}
	
	let encodedFraguaDeVulcano = fraguaDeVulcano.base64EncodedString()
	
	#expect(throws: Never.self) {
		
		let parameter = try ChatCompletionRequestBuilder()
			.withModel(.llama32)
			.withMessage("Eres uno de los conservadores del Museo del Prado", as: .system)
			.withMessage("¿Podrías decirme qué obra es esta y quién es su autor?", as: .user, includingImages: [ fraguaDeVulcano ])
			.build()
		
		#expect(parameter.messages != nil)
		#expect(parameter.messages?.count == 2)
		#expect(parameter.messages?[1].base64EncodedImages?.first == encodedFraguaDeVulcano)
	}
}


extension Tag {
	@Tag static var chatCompletion: Tag
}
