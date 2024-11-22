//
//  openai.swift
//  echo
//
//  Created by Nicholas Scharan on 10/11/24.
//

import Foundation

func sendMessage(message: String, model: String) -> String {
    // Response
    var response: String = "";
    
    // Send Message Closure
    send(prompt: message, model: model) { result in
        switch result {
        case .success(let response_str):
            response = response_str;
        case .failure(let error):
            print("Error: \(error)")
        }
    }
    
    return response;
}

func send(prompt: String, model: String, completion: @escaping (Result<String, Error>) -> Void) {
    // Endpoint URL for OpenAI's chat completion API
    let url = Configuration.OPENAI_BASE_URL
    let token = Configuration.OPENAI_API_KEY
    
    // Set up the request
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")

    // Configure the JSON body with prompt and model information
    let requestBody: [String: Any] = [
        "model": model,
        "messages": [
            ["role": "user", "content": prompt]
        ],
        "temperature": 0.7
    ]
    
    // Convert the body to JSON data
    do {
        request.httpBody = try JSONSerialization.data(withJSONObject: requestBody)
    } catch {
        completion(.failure(error))
        return
    }

    // Create a URLSession data task to send the request
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        // Check for errors in the response
        if let error = error {
            completion(.failure(error))
            return
        }
        
        // Verify data is not nil and parse it
        guard let data = data else {
            completion(.failure(NSError(domain: "OpenAI", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data returned"])))
            return
        }

        // Decode the JSON response
        do {
            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
               let choices = json["choices"] as? [[String: Any]],
               let message = choices.first?["message"] as? [String: Any],
               let content = message["content"] as? String {
                completion(.success(content))
            } else {
                completion(.failure(
                    NSError(domain: "OpenAI", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid response format"])
                ))
            }
        } catch {
            completion(.failure(error))
        }
    }
    
    // Start the request
    task.resume()
}
