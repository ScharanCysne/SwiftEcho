//
//  MessageView.swift
//  echo
//
//  Created by Nicholas Scharan on 10/11/24.
//

import SwiftUI

struct MessageView: View {
    var message: Message
    
    var body: some View {
        HStack {
            if message.from == "user" {
                Spacer()
                Text(message.message)
                    .padding()
                    .background(Color.blue.opacity(0.1))
                    .cornerRadius(12, corners: [.topLeft, .topRight, .bottomLeft], enableBorder: false)
                    .frame(maxWidth: UIScreen.main.bounds.width * 0.7, alignment: .trailing)
            } else {
                Text(message.message)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(12, corners: [.topLeft, .topRight, .bottomRight], enableBorder: false)
                    .frame(maxWidth: UIScreen.main.bounds.width * 0.7, alignment: .leading)
                Spacer()
            }
        }
    }
}

#Preview("Agent") {
    let messageData: MessageData = MessageData()
    
    return MessageView(message: messageData.messages[0]).padding()
}

#Preview("User") {
    let messageData: MessageData = MessageData()
    
    return MessageView(message: messageData.messages[1]).padding()
}

#Preview("Group") {
    let messageData: MessageData = MessageData()
    
    return Group {
        MessageView(message: messageData.messages[0])
        MessageView(message: messageData.messages[1])
    }.padding()
}
