//
//  echoApp.swift
//  echo
//
//  Created by Nicholas Scharan on 10/11/24.
//

import SwiftUI

@main
struct echoApp: App {
    @State private var messageData = MessageData()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(messageData)
        }
    }
}
