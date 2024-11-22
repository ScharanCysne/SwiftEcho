//
//  InputView.swift
//  echo
//
//  Created by Nicholas Scharan on 10/11/24.
//

import SwiftUI

struct InputView: View {
    @Binding var messages: [Message]
    
    @State private var newMessage: String = ""
    
    private func sendMessage() {
        // New User Message
        let newMessage = Message(
            id: messages.count + 1,
            from: "user",
            message: self.newMessage,
            hour: Calendar.current.component(.hour, from: Date()),
            minute: Calendar.current.component(.minute, from: Date())
        )
        messages.append(newMessage)
        
        // New Agent Message
        let response_str = echo.sendMessage(message: self.newMessage, model: "gpt-4o");
        let response = Message(
            id: messages.count + 1,
            from: "agent",
            message: response_str,
            hour: Calendar.current.component(.hour, from: Date()),
            minute: Calendar.current.component(.minute, from: Date())
        )
        messages.append(response);

        // Reset
        self.newMessage = ""
    }
    
    var body: some View {
            HStack {
                HStack {
                    TextField("Ask me anything...", text: $newMessage)
                        .padding(10)
                        .background(Color(.systemGray6))
                        .cornerRadius(20)
                        .onSubmit { 
                            sendMessage()
                        }

                    Button(action: sendMessage) {
                        Image(systemName: "arrow.up.circle.fill")
                            .foregroundColor(.blue)
                            .font(.system(size: 24))
                    }
                    .disabled(newMessage.isEmpty)
                    .padding(.trailing, 10)
                }
                .background(Color(.systemGray6))
                .cornerRadius(25)
            }
            .padding()
        }
}

#Preview {
    InputView(messages: .constant([]))
}
