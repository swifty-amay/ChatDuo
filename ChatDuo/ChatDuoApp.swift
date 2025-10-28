//
//  ChatDuoApp.swift
//  ChatDuo
//
//  Created by Amay's Mac on 27/10/25.
//

import SwiftUI

@main
struct ChatDuoApp: App {
    @StateObject private var authManager = AuthManager()
    var body: some Scene {
        WindowGroup {
            if authManager.isLoggedIn {
                            ChatView()
                                .environmentObject(authManager)
                        } else {
                            LoginView()
                                .environmentObject(authManager)
                        }
        }
    }
}
