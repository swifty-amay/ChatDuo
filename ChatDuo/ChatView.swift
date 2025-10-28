//
//  ChatView.swift
//  ChatDuo
//
//  Created by Amay's Mac on 28/10/25.
//

import SwiftUI

struct ChatView: View {
    @StateObject private var socketManager = WebSocketManager()
    @State private var messageText = ""
    
    var body: some View {
        VStack {
            ScrollView {
                ForEach(socketManager.message, id: \.self) { msg in
                    Text(msg)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                        .padding(.horizontal)
                        .padding(.top, 4)
                }
            }
            
            HStack {
                TextField("Type a message...", text: $messageText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button("Send") {
                    socketManager.sendMessage(messageText)
                    messageText = ""
                }
                .buttonStyle(.borderedProminent)
            }
            .padding()
        }
        .onAppear { socketManager.connect() }
        .onDisappear { socketManager.disconnect() }
    }
}
