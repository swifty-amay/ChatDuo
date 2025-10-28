//
//  WebSocketManager.swift
//  ChatDuo
//
//  Created by Amay's Mac on 28/10/25.
//

import Foundation
import Combine

class WebSocketManager: ObservableObject{
    
    @Published var message: [String] = []
    private var webSocketTask: URLSessionWebSocketTask?
    private let url = URL(string: "wss://ws.ifelse.io")!
    
    func connect(){
        let session = URLSession(configuration: .default)
        webSocketTask = session.webSocketTask(with: url)
        webSocketTask?.resume()
        
        receiveMessage()
        print("Connected")
    }
    
    func sendMessage(_ text: String){
        let message = URLSessionWebSocketTask.Message.string(text)//here Message is a static member that's why its belong to class itself so we didn't used the instace that we created above.
        webSocketTask?.send(message){error in
            if let error = error{
                print("❌ Send error: \(error.localizedDescription)")
            }}
    }
    func receiveMessage(){
        webSocketTask?.receive{[weak self] result in
            switch result{
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            case .success(let message):
                switch message{
                    case .string(let text):
                        DispatchQueue.main.async{   //ui update must happen on main thread beacuse by default the urlwebsockettask runs on background thread.
                            self?.message.append(text)
                    }
                default:
                    print("⚠️ Unknown message type")
                }
            }
            self?.receiveMessage() // keep listening
            }
        
        }
    func disconnect() {
            webSocketTask?.cancel(with: .goingAway, reason: nil)
            print("👋 Disconnected from WebSocket")
        }
}


