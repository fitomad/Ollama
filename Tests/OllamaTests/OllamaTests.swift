import Testing
@testable import Ollama

@Test("Ollama client. Default initialization and configuration", .tags(.client))
func testOllama() {
	let ollama = Ollama()
	
	#expect(ollama.settings.baseURL == "http://localhost:11434")
}

@Test("Ollama client. Custom initialization and configuration", .tags(.client))
func testOllamaCustomSettings() {
	let customSettings = Ollama.Settings(baseURL: "https://example.com:1975")
	let ollama = Ollama(settings: customSettings)
	
	#expect(ollama.settings.baseURL == "https://example.com:1975")
}

@Test("Ollama models", .tags(.model), arguments: [ "llama3.2", "llama3.2:3b", "meta/llama3.2:3b", "research/meta/llama3.2:3b", "research/meta/llama3.2", "meta/llama3.2" ])
func testModels(content: String) {
	#expect(throws: Never.self) {
		let _ = Model(rawValue: content)
	}
}

@Test("ChatCompletion. Development prompts", .tags(.endpoints), arguments: Prompts.development)
func testChatCompletion(prompt: String) async throws {
	let chatCompletionParameter = try ChatCompletionRequestBuilder()
		.withModel(.llama32)
		.withMessage("You're a senior Swift developer", as: .system)
		.withMessage(prompt, as: .user)
		.withStreamSupport(false)
		.withModelTemperature(0.1)
		.build()
	
	let ollama = Ollama()
	let chatCompletionResponse = try await ollama.chatCompletion(parameter: chatCompletionParameter)
	
	#expect(chatCompletionResponse.message.content.isEmpty == false)
	
	print("📣 (\(chatCompletionResponse.message.role.rawValue)): \(chatCompletionResponse.message.content)")
}

@Test("ChatCompletion. Twitter prompts", .tags(.endpoints), arguments: Prompts.communityManager)
func testChatCompletionWithTemperature(prompt: String) async throws {
	let chatCompletionParameter = try ChatCompletionRequestBuilder()
		.withModel(.llama32)
		.withMessage("Act as a Twitter Community Manager", as: .system)
		.withMessage(prompt, as: .user)
		.withStreamSupport(false)
		.withModelTemperature(1.5)
		.build()
	
	let ollama = Ollama()
	let chatCompletionResponse = try await ollama.chatCompletion(parameter: chatCompletionParameter)
	
	#expect(chatCompletionResponse.message.content.isEmpty == false)
	
	print("📣 (\(chatCompletionResponse.message.role.rawValue)): \(chatCompletionResponse.message.content)")
}

@Test("Running Models.", .tags(.endpoints))
func testRunningModels() async throws {
	let ollama = Ollama()
	let runningModels = try await ollama.runningModels()
}

@Test("Local Models.", .tags(.endpoints))
func testLocalModels() async throws {
	let ollama = Ollama()
	let localModels = try await ollama.localModels()
	
	#expect(localModels.isEmpty == false)
}

@Test("Delete models", .tags(.endpoints))
func testDeleteModel() async throws {
	let ollama = Ollama()
	
	let deleteModelRequest = try DeleteModelRequestBuilder()
		.withModel(named: "llama3.2")
		.build()
	
	let deletedModel = try await ollama.deleteModel(parameter: deleteModelRequest)
	
	#expect(deletedModel.isOK)
}

@Test("Completion.", .tags(.endpoints))
func testCompletion() async throws {
	let completionRequest = try CompletionRequestBuilder()
		.withModel(.llama32)
		.withPrompt("Tell me something about Spain")
		.withSystemMessage("You are a travel agency worker expert in Spain.")
		.withStreamSupport(false)
		.withRawSupport(false)
		.build()
	
	let ollama = Ollama()
	let completionResponse = try await ollama.completion(parameter: completionRequest)
	
	#expect(completionResponse.response.isEmpty == false)
	dump(completionResponse)
	debugPrint(completionResponse.response)
}

enum Prompts {
	static var development: [String] {
		[
			"Could you tell me please the most used Swift web frameworks?",
			"Explain me what is Event-Driven Architecture",
			"Could you tell me some uses case for Apache Pulsar?"
		]
	}
	
	static var communityManager: [String] {
		[
			"""
			Create a tweet for a user that is Atlético de Madrid supporter. We want that users knows the new Atlético the Madrid web store. The tweet must be in Spanish.
			- This is the link for the online store: https://shop.atleticodemadrid.com/
			- This is the Atletico de Madrid twitter user: @Atleti
			- Atlético de Madrid doesn't use hashtags in his tweets.
			"""
		]
	}
}

extension Tag {
	@Tag static var endpoints: Tag
	@Tag static var client: Tag
	@Tag static var model: Tag
}
