//
//  File.swift
//  echo
//
//  Created by Nicholas Scharan on 11/11/24.
//

import Foundation

enum Configuration {
    // Variables
    static var OPENAI_API_KEY: String {
        read(for: "OPENAI_API_KEY")
    }
    static var OPENAI_BASE_URL: URL {
        URL(string: read(for: "OPENAI_BASE_URL"))!
    }
    
    // Reader
    static private func read(for key: String) -> String {
        Bundle.main.infoDictionary?[key] as! String
    }
}
