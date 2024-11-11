//
//  ContentView.swift
//  echo
//
//  Created by Nicholas Scharan on 10/11/24.
//

import SwiftUI

struct ContentView: View {
    @Environment(MessageData.self) var messageData
    
    var body: some View {
        @Bindable var messageData = messageData
        
        VStack {
            SoundWaveView().frame(height: 50)
            MessageHistoryView(messages: messageData.messages)
            Spacer()
            InputView(messages: $messageData.messages)
        }
    }
}

#Preview {
    ContentView()
        .environment(MessageData())
}
