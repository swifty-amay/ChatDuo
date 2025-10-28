//
//  MainView.swift
//  ChatDuo
//
//  Created by Amay's Mac on 27/10/25.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var authManager: AuthManager
    var body: some View {
            VStack(spacing: 20) {
                Text("🎉 Welcome, you're logged in!")
                    .font(.title)
                
                Button("Logout") {
                    authManager.logout()
                }
                .buttonStyle(.borderedProminent)
            }
            .padding()
        }
}

#Preview {
    MainView()
}
