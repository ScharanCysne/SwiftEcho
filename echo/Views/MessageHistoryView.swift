//
//  MessageHistoryView.swift
//  echo
//
//  Created by Nicholas Scharan on 10/11/24.
//

import SwiftUI

struct MessageHistoryView: View {
    var messages: [Message]
    
    var body: some View {
        ScrollViewReader { scrollViewProxy in
            ScrollView {
                VStack(spacing: 10) {
                    ForEach(messages) { message in
                        MessageView(message: message)
                    }
                }
                .padding()
            }
            .onChange(of: messages) {
                if let lastMessage = messages.last {
                    scrollViewProxy.scrollTo(lastMessage.id, anchor: .bottom)
                }
            }
        }
    }
}

#Preview {
    let messageData: MessageData = MessageData()
    
    return MessageHistoryView(messages: messageData.messages)
}
