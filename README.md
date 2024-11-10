# Ollama. A Swift Library for Ollama

A Swift library providing a simple interface to the OLLama API endpoint, currently supporting the follwing endpoints:
				
- Completion
- Chat Completion
- Running models
- List local models

I use the new [SwiftTesting](https://developer.apple.com/xcode/swift-testing/) framework to develop and run the framework unit tests.

## Features

* 100% Swift library
* No thrid party libraries dependencies
* Fast and efficient data retrieval (I guess 😜)

## Usage

The Ollama library makes use of the *Builder* pattern to create request parameters for each endpoint.

### Installation

Add the Ollama framework as a Swift Package using the following command

```zsh
swift package add-dependency https://github.com/fitomad/Ollama.git
```

Or you can use the Xcode Swift Package Dependecy manager tool available in the project settings view.

### Using the Library

First you must import the library into your Swift file using:

```swift
import Ollama
```

Now you are ready to make request to your Ollama models, for example, below this lines you will find an example about how-to make a request to the Completion endpoint.

1. Create the completion request parameter using the `CompletionRequestBuilder`
2. With the new parameters, make the request using the `Ollama` client.

```swift
do {
	let completionRequest = try CompletionRequestBuilder()
		.withModel(.llama32)
		.withPrompt("Tell me something about Spain")
		.withSystemMessage("You are a travel agency worker expert in Spain.")
		.withStreamSupport(false)
		.withRawSupport(false)
		.build()

	let ollama = Ollama()
	let completionResponse = try await ollama.completion(parameter: completionRequest)
} catch let builderError as OllamaBuilderError {
	debugPrint("Wrong parameters...\(builderError.localizedDescription)")
} catch let ollamaError as OllamaError {
	debugPrint("Request failure...\(ollamaError.localizedDescription)")
}
```

## Ollama REST API Documentation

Please refer to the Ollama [API
documentation](https://github.com/ollama/ollama/blob/main/docs/api.md) for detailed
information on each endpoint and method.

## License

This project is licensed under the MIT license. See
[LICENSE](https://github.com/your-username/OLlamaAPIEndpoint/blob/main/LICENSE) for more information.

## Author

[Adolfo] ([LinkedIn](https://www.linkedin.com/in/adolfo-vera/))

## Acknowledgments

I would like to thank [Ollama API Team](https://ollama.com/) for providing the API endpoint and documentation.

## Version history

### 0.2

- `OllamaModel` enumeration becomes `Model` structure

Added the following endpoints

- Delete model

### 0.1

Support for the following endpoints

- Completion
- Chat Completion
- Running models
- List local models
