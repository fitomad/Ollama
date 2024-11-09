//
//  Options.swift
//  Ollama
//
//  Created by Adolfo Vera Blasco on 8/11/24.
//

import Foundation

public struct Options: Encodable {
	var seed: Int?
	var temperature: Double?
}
