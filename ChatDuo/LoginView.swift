//
//  LoginView.swift
//  ChatDuo
//
//  Created by Amay's Mac on 27/10/25.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var message = ""
    @State private var isRegisterMode = false
    @EnvironmentObject var authManager: AuthManager
    var body: some View {
        
        VStack(spacing: 20){
            Text(isRegisterMode ? "Register" : "Login")
                            .font(.largeTitle)
                            .bold()
            TextField("Email", text: $email)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                            .autocapitalization(.none)
            SecureField("Password", text: $password)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .autocapitalization(.none)
                            .padding()
            Button(isRegisterMode ? "Register" : "Login") {
                            Task {
                                do {
                                    if isRegisterMode{
                                      _ = try await AuthService.shared.register(email: email, password: password)
                                        isRegisterMode = false
                                    }else{
                                        let result = try await AuthService.shared.login(email: email, password: password)
                                        message = "✅ Token saved: \(result.token)"
                                        authManager.isLoggedIn = true // 👈 Switch to MainView
                                        //This is to switch to main view after user log in first time and then after the token get saved the condition is checked at the starting of app and then view is called accordingly.
                                    }
                                } catch {
                                    message = "❌ Error: \(error.localizedDescription)"
                                }
                            }
                        }
                        .buttonStyle(.borderedProminent)
                        
                        Button(isRegisterMode ? "Already have an account? Login" : "Don’t have an account? Register") {
                            isRegisterMode.toggle()
                            message = ""
                        }
                        
                        Text(message)
                            .foregroundColor(.gray)
                            .padding()
                    }
                    .padding()
                }
            }

#Preview {
    LoginView()
}
